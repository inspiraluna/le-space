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
        /* def contractStart = new DateTime()
        //contractStart.minusMonths(-1)
        contractStart.withDayOfMonth(1)

        def contractEnd = new DateTime()
        contractEnd.withDayOfMonth(1)
        contractEnd.plusMonths(1)
        contractEnd.minusDays(1)
         */

        def report = new Report()
        report.properties = params

        def dateFrom = new Date()
        def dateTo = new Date()

        //dateFrom
        if(report.dateFrom) session["dateFrom"] = report.dateFrom
        if(session["dateFrom"])dateFrom = session["dateFrom"]

        //dateTo
        if(report.dateTo) session["dateTo"] = report.dateTo
        if(session["dateTo"])dateTo = session["dateTo"]

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

        //active within time range
        if(dateFrom || dateTo){
            if(first){
                first = false
                hql+="where "
            }
            else
                hql+="and "

            MutableDateTime dtFrom = new DateTime(dateFrom).toMutableDateTime()
            dtFrom.setHourOfDay(0)
            dtFrom.setMinuteOfHour(0)
            dtFrom.setSecondOfMinute(0)
            log.debug dtFrom

            MutableDateTime dtTo = new DateTime(dateTo).toMutableDateTime()
            dtTo.setHourOfDay(23)
            dtTo.setMinuteOfHour(59)
            dtTo.setSecondOfMinute(59)
            log.debug dtTo
 
            hql+="( (c.contractStart >= :fromDate and c.contractEnd <= :toDate) or "
            hql+=" (c.contractStart <= :fromDate and c.contractEnd >= :fromDate) or"
            hql+=" (c.contractStart <= :toDate and c.contractEnd >= :toDate) or "
            hql+=" (c.contractStart <= :fromDate and c.contractEnd >= :toDate) or "
           
            hql+=" (c.contractStart >= :fromDate and ((c.contractEnd is null and c.cancelationDate is null) or (c.contractEnd is null and c.cancelationDate <= :toDate))) "
            hql+=" or (c.contractStart <= :fromDate and ((c.contractEnd is null and c.cancelationDate is null) or (c.contractEnd is null and c.cancelationDate >= :fromDate))) "
            hql+=" or (c.contractStart <= :toDate   and ((c.contractEnd is null and c.cancelationDate is null) or (c.contractEnd is null and c.cancelationDate >= :toDate))) "
            hql+=" or (c.contractStart <= :fromDate and ((c.contractEnd is null  and c.cancelationDate is null) or (c.contractEnd is null and c.cancelationDate >= :fromDate))))"

            hparams.put("fromDate",dtFrom.toDateTime().toDate())
            hparams.put("toDate",dtTo.toDateTime().toDate())

    }

    //select distinct c from le.space.Contract c left join c.customer cu left join c.customer.shiroUsers u where (c.contractStart >= :contractStart and c.contractEnd <= :contractEnd) or (c.contractStart <= :contractStart and c.contractEnd >= :contractStart) or (c.contractStart <= :contractEnd and c.contractEnd >= :contractEnd) or (c.contractStart <= :contractStart and c.contractEnd >= :contractEnd) or (c.contractStart >= :contractStart and ((c.autoExtend==true and c.cancelationDate is null) or (c.autoExtend==true and c.cancelationDate <= :contractEnd))) or (c.contractStart <= :contractStart and ((c.autoExtend==true and c.cancelationDate is null) or (c.autoExtend==true and c.cancelationDate >= :contractStart))) or (c.contractStart <= :contractEnd and ((c.autoExtend==true and c.cancelationDate is null) or (c.autoExtend==true and c.cancelationDate >= :contractEnd))) or (c.contractStart <= :contractStart and ((c.autoExtend==true and c.cancelationDate is null) or (c.autoExtend==true and c.cancelationDate >= :contractEnd))) order by c.id desc

    if(searchText){
        if(first){
            first = false
            hql+=" where "
        }
        else
        hql+=" and "

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

    log.debug "${hql} searchText:${searchText} paid:${paid} valid:${valid} "
      
    hparamsAll.putAll(hparams)

    hparams.put("max",max)
    hparams.put("offset",offset)

    //log.debug "max:${max} offset: ${offset} "

    def contractListAll = Contract.executeQuery(hql,hparamsAll)
    // log.debug "contractListAll.size() ${contractListAll.size}"
    def contractList = Contract.executeQuery(hql,hparams)
    //log.debug "contractList.size() ${contractList.size}"


    List fields = ["id", "customer.firstname", "customer.lastname","customer.company","customer.city","amountGross","autoExtend","valid","paid"]
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
        searchText:searchText,dateFrom:dateFrom,
        dateTo:dateTo,params:params]
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
    [
        revenueByMonth: revenueByMonth,
        revenueByMonthOrderByDateDesc:revenueByMonthOrderByDateDesc,
        revenueByCustomer:revenueByCustomer,
        loginsByMonthYear:loginsByMonthYear,
        loginsByDate:loginsByDate
    ]
}
}
