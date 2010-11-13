package le.space
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.joda.time.*
import org.joda.time.format.*

class ContractController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def exportService

    def list = {
        int max = 10
        int offset = 0
        def sort = "id"
        def order = "desc"
        def searchText = ""

        String paid
        String valid
        //session max
        if(params.max) session["max"] = params.max
        if(session["max"])max = session["max"]?.toInteger()

        //session offset
        if(params.offset) session["offset"] = params.offset
        if(session["offset"])offset = session["offset"]?.toInteger()

        ////session order
        if(params.order) session["order"] = params.order
        if(session["order"])order = session["order"]

        ////session sort
        if(params.sort) session["sort"] = params.sort
        if(session["sort"])sort = session["sort"]

        if(params.searchText || params.searchText=="") session.searchText = params.searchText
        if(session.searchText) searchText = session.searchText

        if(params.paid) session.paid = params.paid
        paid = session.paid

        if(params.valid) session.valid = params.valid
        valid = session.valid

        
        def hparamsAll = [:]
        def hparams = [:]

        boolean first = true

        def hql = "select c from le.space.Contract  c "
        hql+= " left join c.customer.shiroUsers u "
        
        if(paid && paid!="all"){
            first = false
            hql+="where c.paid=:paid "
            hparams.put("paid",new Boolean(paid).booleanValue())
        }

        if(valid && valid!="all"){
            if(first){
                first = false
                hql+="where "
            }
            else
            hql+="and "

            hql+="c.valid=:valid "
            hparams.put("valid",new Boolean(valid).booleanValue())
        }

        if(searchText){
            if(first){
                first = false
                hql+="where "
            }
            else
            hql+="and "

            if(HelperTools.isNumeric(searchText)){
                hql+=" c.id=:id "
                hparams.put("id",new Long(searchText))
            }
            else{
                hql+=" (upper(u.firstname) like upper(:searchText) or upper(u.lastname) like upper(:searchText) "
                hql+=" or upper(c.customer.company) like upper(:searchText) or upper(u.occupation) like upper(:searchText) "
                hql+=" or upper(c.customer.city) like upper(:searchText) or upper(u.email) like upper(:searchText))"
                hparams.put("searchText","%"+searchText+"%")
            }   
        }
        hql+=" order by c."

        hql+= sort
        hql+=" "+order

        log.debug "${hql} searchText:${searchText} paid:${paid} valid:${valid}"
      
        hparamsAll.putAll(hparams)

        hparams.put("max",max)
        hparams.put("offset",offset)

        log.debug "max:${max} offset: ${offset} "

        def contractListAll = Contract.executeQuery(hql,hparamsAll)
        log.debug "contractListAll.size() ${contractListAll.size}"
        def contractList = Contract.executeQuery(hql,hparams)
        log.debug "contractList.size() ${contractList.size}"


        List fields = ["id", "firstname", "lastname","company","city","amountGross","autoExtend","valid","paid"]
        Map labels = ["id":"Vertragsnummer","firstname":"Vorname","lastname":"Nachname","city":"Stadt","amountGross":"Betrag (brutto)","auto_extend":"Auto-Verlängerung"]
        Map formatters = [:]
        Map parameters = [:]
        
        //Map labels = ["author": "Author", "title": "Title"]

        /* Formatter closure in previous releases def upperCase = { value -> return value.toUpperCase() } */

        // Formatter closure def upperCase = { domain, value -> return value.toUpperCase() }

        //Map formatters = [author: upperCase]
        //Map parameters = [title: "Cool books", "column.widths": [0.2, 0.3, 0.5]]

        //exportService.export(params.format, response.outputStream, Book.list(params), fields, labels, formatters, parameters)


        if(params?.format && params.format != "html"){
            response.contentType = ConfigurationHolder.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=contracts.${params.extension}")
            exportService.export(params.format, response.outputStream,contractListAll,  fields, labels, formatters, parameters)
        }

        [contractInstanceList: contractList,
            totalCount: contractListAll.size(),
            max:max,
            offset:offset,
            order:order,
            paid:paid,
            valid:valid,
            sort:sort,
            searchText:searchText,params:params]
    }

    def create = {
        def contractInstance = new Contract()
        contractInstance.properties = params
        return [contractInstance: contractInstance]
    }

    def save = {
        def contractInstance = new Contract(params)
        if (contractInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'contract.label', default: 'Contract'), contractInstance.id])}"
            redirect(action: "show", id: contractInstance.id)
        }
        else {
            render(view: "create", model: [contractInstance: contractInstance])
        }
    }

    def duplicate = {
        def contractNew = le.space.HelperTools.deepClone(Contract.get(params.id))
        flash.message = "${message(code: 'default.duplicated.message', args: [message(code: 'contract.label', default: 'Contract'), contractNew.id])}"
        render(view: "create", model: [contractInstance: contractNew])
    }

    def previous = {
        params.id = new Integer(params.id) - 1
        chain(action:"show", model:[data:[session.contract]],params:params)
    }

    def next = {
        params.id = new Integer(params.id) + 1
        chain(action:"show", model:[data:[session.contract]],params:params)
    }

    def show = {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
        else {
            [contractInstance: contractInstance]
        }
    }

    def edit = {
        def contractInstance = Contract.get(params.id)
        if (!contractInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [contractInstance: contractInstance]
        }
    }

    def update = {
        def contractInstance = Contract.get(params.id)
        if (contractInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (contractInstance.version > version) {
                    
                    contractInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'contract.label', default: 'Contract')] as Object[], "Another user has updated this Contract while you were editing")
                    render(view: "edit", model: [contractInstance: contractInstance])
                    return
                }
            }
            contractInstance.properties = params
            if (!contractInstance.hasErrors() && contractInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'contract.label', default: 'Contract'), contractInstance.id])}"
                redirect(action: "show", id: contractInstance.id)
            }
            else {
                render(view: "edit", model: [contractInstance: contractInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def contractInstance = Contract.get(params.id)
        if (contractInstance) {
            try {
                contractInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
    }

    /**
     * This controller method should be moved into a service! 
     */
    def addLogin = {
        def contractInstance = Contract.get(params.id)
        def shiroUser = ShiroUser.get(params.userId)

        if (contractInstance) {
            def login = new Login(user:null,ipAddress:null,macAddress:null,loginStart:new Date()).save()
            log.debug "saved new login ${login}}"
            contractInstance.addToLogins(login)
                
            log.debug "Product ${contractInstance.getProducts().toArray()[0]} has durationType:${contractInstance.getProducts().toArray()[0].durationType}"

            //wenn heute schon ein login war diesen login nicht noch einmal zählen!
            if(contractInstance.getProducts().toArray()[0].allowedLoginDays>0){
                contractInstance.allowedLoginDaysLeft--
                contractInstance.loginDays++
                   
                log.debug "allowedLoginDayLeft:${contractInstance.allowedLoginDaysLeft}"
            }
            contractInstance.lastLogin = new Date()
            contractInstance.save()
        }

       
        redirect(action: "list")
    }

    def addTest = {
        new RegistrationTests().runTests()

        redirect(action: "list")
    }

    /**
     * Add a payment to a certain contract
     */
    def addFullPayment = {
        def contractInstance = Contract.get(params.id)
        if (contractInstance) {


            double amountGross = contractInstance.amountGross
            double sumPaid = contractInstance.amountPaid
            
            if(contractInstance.autoExtend){
                Months months = Months.monthsBetween(new DateTime(contractInstance.contractStart).withTime(0,0,0,0), new DateTime().withTime(23,59,59,999))
                int monthsGone = months.getMonths()            
                amountGross = amountGross*(monthsGone+1)
            }
            double amountToPay = amountGross - sumPaid

            if(amountToPay>0){
                def payment = new Payment(amount:amountToPay,paymentDate:new Date(),paymentMethod:Payment.PM_DIRECT_DEBIT,contract:contractInstance).save()
                log.debug "saved new payment"
                contractInstance.save()
                log.debug "added payment ${payment} to contract ${contractInstance}"
            }
          
        }
        redirect(action: "show",id:params.id)
    }
}
