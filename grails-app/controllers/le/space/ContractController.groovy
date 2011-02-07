package le.space
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.joda.time.*
import org.joda.time.format.*
import org.apache.shiro.SecurityUtils

class ContractController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def loginService 
    def exportService

    def redirect = {
        
        session.loginParams
        //["resession.loginParams.res,
        //"uamip":"192.168.182.1",
        //"challenge":"1bdff835c8bf541fe23f2f26ce66c975",
        //"nasid":"le-space_spot",
        //"userurl":"http://www.facebook.com/",
        //"mac":"00-1C-B3-BD-E8-9E",
        //"uamport":"3990",
        //"action":"login",
        //"controller":"home"]
    }

    def profile = {

        def shiroUser = le.space.ShiroUser.findByUsername(SecurityUtils.getSubject().principal)
        
        def hql="select co from le.space.Contract  co "
        hql+="inner join co.customer cu "
        hql+="inner join cu.shiroUsers u "
        hql+="WHERE u.username=:username "
        hql+="ORDER BY co.contractStart desc"
            
        def hparams = [username:shiroUser.username]

        def contractList = Contract.executeQuery(hql,hparams)
        def contract = contractList[0]
        def loginList = loginService.getDayLogins(contract)

        log.debug " logins.. ${loginList}"
        
        [bodyId:"profile", 
            slogan: g.message(code: 'contract.profile.welcome',
                args: [shiroUser.firstname,shiroUser.lastname,shiroUser.email]),
            shiroUser:shiroUser,
            contract:contract,
            contractList:contractList,loginList:loginList]
    }

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

        //log.debug "Contracts:${le.space.Contract.list()}"
        //log.debug "Customers:${le.space.Customer.list()}"
        //log.debug "ShiroUsers:${le.space.ShiroUser.list()}"

        def hql = "select distinct c from le.space.Contract  c "
        hql+= " left join c.customer cu"
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
                hql+=" or cu.id=:id "
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

        //log.debug "${hql} searchText:${searchText} paid:${paid} valid:${valid}"
      
        hparamsAll.putAll(hparams)

        hparams.put("max",max)
        hparams.put("offset",offset)

        //log.debug "max:${max} offset: ${offset} "

        def contractListAll = Contract.executeQuery(hql,hparamsAll)
        // log.debug "contractListAll.size() ${contractListAll.size}"
        def contractList = Contract.executeQuery(hql,hparams)
        //log.debug "contractList.size() ${contractList.size}"


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

    
    def addContract = {

        def contractInstance = new Contract(params)
        def customer = Customer.get(params.customer.id)
        log.debug "adding new contract to customer ${customer}"

        contractInstance.customer = customer
        
        if (contractInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'contract.label', default: 'Contract'), contractInstance.id])}"
            //redirect(action: "show", id: contractInstance.id)
        }
        //render(view: "customerContracts", controller:"customer", model: [contractInstance: contractInstance] )
    }

    def create = {
        def contractInstance = new Contract()
        contractInstance.properties = params
        return [contractInstance: contractInstance]
    }

    def save = {
        def contractInstance = new Contract(params)
        //
        //log.debug "${contractInstance}"
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

            [contractInstance: contractInstance, loginList:loginService.getDayLogins(contractInstance)]
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
        def customer = contractInstance.customer

        log.debug "update of contract: ${contractInstance} ${customer} ${contractInstance.allowedLoginDaysLeft} "

        if (contractInstance && customer) {
            if (params.version) {
                def version = params.version.toLong()
                if (contractInstance.version > version) {                
                    contractInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'contract.label', default: 'Contract')] as Object[], "Another user has updated this Contract while you were editing")
                    render(view: "show", model: [contractInstance: contractInstance])
                    return
                }
            }
            contractInstance.properties = params
            customer.properties = params
            
            if (!contractInstance.hasErrors() && !customer.hasErrors() && contractInstance.save(flush: true) && customer.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'contract.label', default: 'Contract'), contractInstance.id])}"
                redirect(action: "show", id: contractInstance.id)
            }
            else {
                render(view: "show", model: [contractInstance: contractInstance])
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
        //def contractInstance = Contract.get(params.id)
        //def shiroUser = ShiroUser.get()

        log.debug "logging in userId:${params.userId} contract: ${params.id}"
        loginService.login(params.userId,null,null)
        redirect(action: "list")
    }

    def addTest = {
        redirect(action: "list")
    }

    /**
     * Add a payment to a certain contract
     */
    def addFullPayment = {
        def contractInstance = Contract.get(params.id)
        if (contractInstance) {
  
            if(contractInstance.amountDue>0){
                def payment = new Payment(amount:contractInstance.amountDue,paymentDate:new Date(),paymentMethod:Payment.PM_DIRECT_DEBIT,customer:contractInstance.customer).save()
                log.debug "saved new payment"               
                log.debug "added payment ${payment} to customer ${contractInstance.customer}"
            }        
        }
        redirect(action: "show",id:params.id)
    }
    
    def stat = {
        //select sum(amount_gross), month(contract_start), year(contract_start) from contract group by month(contract_start), year(contract_start) order by 1 desc
        def hql = "select sum(amountGross) as amount, year(contractStart)||' '||month(contractStart) "
        hql+="  from le.space.Contract  c "
        hql+=" group by month(contractStart), year(contractStart)"
        hql+= " order by sum(amountGross) desc "
        def hparams = []
        def revenueByMonth = Contract.executeQuery(hql,hparams)

        //select sum(amount_gross), month(contract_start), year(contract_start) from contract group by month(contract_start), year(contract_start) order by 1 desc
        hql = "select sum(amountGross) as amount, year(contractStart)||'-'||month(contractStart) as monthyear "
        hql+="  from le.space.Contract  c "
        hql+=" group by month(contractStart), year(contractStart)"
        hql+= " order by contractStart desc "
        hparams = []
        def revenueByMonthOrderByDateDesc = Contract.executeQuery(hql,hparams)

        hql = "select sum(amountGross) as amount, customer.id "
        hql+="  from le.space.Contract  c "
        hql+=" group by customer.id"
        hql+= " order by sum(amountGross) desc "
        hparams = []
        def revenueByCustomer = Contract.executeQuery(hql,hparams)


        hql = "select count(id), year(loginStart)||'-'||month(loginStart) as monthyear from le.space.Login "
        hql+= "group by year(loginStart)||'-'||month(loginStart) "
        hql+= "order by loginStart desc "
        hparams = []
        def loginsByMonthYear = Contract.executeQuery(hql,hparams)

        hql = "select count(id), date(loginStart) from le.space.Login "
        hql+= "group by date(loginStart)  "
        hql+= "order by date(loginStart) desc "
        hparams = []

        def loginsByDate = Contract.executeQuery(hql,hparams)
        /**
        def c = Contract.get(96)
        log.debug "contract: ${c.id}"
        hparams = [contractStart:c.contractStart]
        hql = "select date(l.loginStart) from le.space.Login l "
        hql+= "where l.loginStart >= :contractStart "

        if(c.cancelationDate){
        hql+= "and (l.loginStart <= :cancelationDate) "
        hparams.put("cancelationDate",c.cancelationDate)
        }
        else if(c.contractEnd){
        hql+= "and (l.loginStart <= :contractEnd) "
        hparams.put("contractEnd",c.contractEnd)
        }
        hql+=" and ("

        int i = 0
        c.customer.shiroUsers.each{
        if(i>0)
        hql+=" or "
        hql+="l.user=:shiroUser"+i
        hparams.put("shiroUser"+i,it)
        i++
        }
        hql+= ") "
        hql+= "group by date(l.loginStart)  "
        // hql+= "order by date(l.loginStart) desc "
        log.debug hql
        log.debug hparams
        def loginsByCustomer = Contract.executeQuery(hql, hparams).size()
         */
        loginsByCustomer = null
        [
            loginsByCustomer: loginsByCustomer,
            revenueByMonth: revenueByMonth,
            revenueByMonthOrderByDateDesc:revenueByMonthOrderByDateDesc,
            revenueByCustomer:revenueByCustomer,
            loginsByMonthYear:loginsByMonthYear,
            loginsByDate:loginsByDate
        ]
    }
}
