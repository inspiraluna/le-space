package le.space
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.joda.time.*
import org.joda.time.format.*
import org.apache.shiro.SecurityUtils
import de.jost_net.OBanToo.Dtaus.*


class ContractController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def loginService 
    def contractService
    def paymentService
    def exportService

    def profile = {

        def username = SecurityUtils.getSubject().principal
        def shiroUser = ShiroUser.findByUsername(username)
        def contractList = contractService.getContractsOfUsername(username)
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
        boolean loggedInOnly = false
        def sort = "lastLogin"
        def order = "desc"
        def searchText = ""


        def report = new Report()
        report.properties = params

        def dateFrom = new Date()
        def dateTo = new Date()

        def dtDateFrom = new DateTime()
        // dtDateFrom=dtDateFrom.minusMonths(1)
        // dtDateFrom=dtDateFrom.withDayOfMonth(1)

        def dtDateTo = new DateTime()
        /*  dtDateTo=dtDateTo.withDayOfMonth(1)
        dtDateTo=dtDateTo.plusMonths(1)
        dtDateTo=dtDateTo.minusDays(1)
         */
        dateFrom = dtDateFrom.toDate()
        dateTo = dtDateTo.toDate()

        log.debug "dateFrom:${dateFrom}"
        log.debug "dateTo:${dateTo}"

        //dateFrom
        if(report.dateFrom) session["dateFrom"] = report.dateFrom
        if(session["dateFrom"])dateFrom = session["dateFrom"]

        //dateTo
        if(report.dateTo) session["dateTo"] = report.dateTo
        if(session["dateTo"])dateTo = session["dateTo"]
        
        log.debug "dateFrom:${dateFrom}"
        log.debug "dateTo:${dateTo}"

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

        if(params.loggedInOnly) session.loggedInOnly = true
        else session.loggedInOnly = false
        
        loggedInOnly = session.loggedInOnly
        
        if(params.searchProducts) session.searchProducts = params.searchProducts
        def searchProducts = session.searchProducts


        def hparamsAll = [:]
        def hparams = [:]

        boolean first = true

        def hql = "select distinct c from le.space.Contract  c "
        hql+= " left join c.customer cu"
        hql+= " left join c.products p"
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

            MutableDateTime dtTo = new DateTime(dateTo).toMutableDateTime()
            dtTo.setHourOfDay(23)
            dtTo.setMinuteOfHour(59)
            dtTo.setSecondOfMinute(59)
 
            hql+="((c.contractStart >= :fromDate and c.contractEnd <= :toDate) or "
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
        
        log.debug "loggedInOnly: ${params.loggedInOnly} ${loggedInOnly}"

        if(loggedInOnly){
            hql+= "AND (c.lastLogin <= :now and c.lastLogin >= :todayMorning) "

            MutableDateTime mDtTodayMorning = new DateTime().toMutableDateTime()
            mDtTodayMorning.setHourOfDay(0)
            mDtTodayMorning.setMinuteOfHour(0)
            mDtTodayMorning.setSecondOfMinute(0)

            hparams.put("now",new Date())
            hparams.put("todayMorning",mDtTodayMorning.toDateTime().toDate())

        }

        if(searchProducts && searchProducts!='null'){
            log.debug searchProducts
            hql+="and ("
            int i = 0
            searchProducts.each{
                log.debug it
                i++
                if(i>1)
                hql+=" or "
                hql+=" p.id=:pro "
                hparams.put("pro",it.toLong())
            }
            hql+=")"
        }

        hql+=" order by c."

        hql+= sort
        hql+=" "+order

        log.debug "${hql} ${hparams} "
      
        hparamsAll.putAll(hparams)

        hparams.put("max",max)
        hparams.put("offset",offset)

        //log.debug "max:${max} offset: ${offset} "

        def contractListAll = Contract.executeQuery(hql,hparamsAll)

        //all verträge neu durchrechnen!
        try {
            contractListAll.each{
                paymentService.calculatePayments(it)
            }
        }
        catch(Exception ex){log.debug "problem with calculation of contract..."}
        // log.debug "contractListAll.size() ${contractListAll.size}"
        def contractList = Contract.executeQuery(hql,hparams)
        //log.debug "contractList.size() ${contractList.size}"


        List fields = ["id", "customer.id","customer.debitNo","customer.firstname", "customer.lastname","customer.company","contractStart","contractEnd","amountGross","autoExtend","paid","customer.bankAccount.directDebitPermission"]
        Map labels = ["id":"V-Nr.","customer.id":"KdNr.","customer.debitNo":"Deb.Nr.","customer.firstname":"Vorname","customer.lastname":"Nachname","contractStart":"von","contractEnd":"bis","customer.city":"Stadt","customer.company":"Firma","amountGross":"Betrag (brutto)","autoExtend":"Auto-Verlängerung","customer.bankAccount.directDebitPermission":"LS"]
        def datum = { domain, value -> return value?.getDateString()}
        Map formatters = [contractStart:datum,contractEnd:datum]
        Map parameters = [:]
        // Map formatters = [:]
        //Map labels = ["author": "Author", "title": "Title"]

        /* Formatter closure in previous releases def upperCase = { value -> return value.toUpperCase() } */

        // Formatter closure def upperCase = { domain, value -> return value.toUpperCase() }

        //
        //
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
            loggedInOnly:loggedInOnly,
            searchText:searchText,
            dateFrom:dateFrom,
            dateTo:dateTo,
            searchProducts:searchProducts,
            params:params]
    }

    
    def addContract = {

        def contract = new Contract(params)
        def customer = Customer.get(params.customer.id)
        log.debug "adding new contract to customer ${customer}"

        contract.customer = customer
        
        if (contract.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'contract.label', default: 'Contract'), contract.id])}"
        }
    }

    def create = {
        def contract = new Contract()
        contract.properties = params
        return [contract: contract]
    }

    def save = {
        def contract = new Contract(params)

        if (contract.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'contract.label', default: 'Contract'), contract.id])}"
            redirect(action: "show", id: contract.id)
        }
        else {
            render(view: "create", model: [contract: contract])
        }
    }

    def duplicate = {
        def contractNew = le.space.HelperTools.deepClone(Contract.get(params.id))
        flash.message = "${message(code: 'default.duplicated.message', args: [message(code: 'contract.label', default: 'Contract'), contractNew.id])}"
        render(view: "create", model: [contract: contractNew])
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
        def contract = Contract.get(params.id)
        if (!contract) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
        else {
            def contractList = contractService.getContractsOfCustomer(contract.customer)
            log.debug "contractList.size():${contractList.size()}"
            [contract: contract, loginList:loginService.getDayLogins(contract),contractList:contractList]
        }
    }

    def edit = {
        def contract = Contract.get(params.id)
        if (!contract) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [contract: contract]
        }
    }

    def update = {

        def contract = Contract.get(params.id)
        log.debug "update of contract: ${contract}"
        if (contract) {
            if (params.version) {
                def version = params.version.toLong()
                if (contract.version > version) {
                    contract.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'contract.label', default: 'Contract')] as Object[], "Another user has updated this Contract while you were editing")
                    render(view: "show", model: [contract: contract])
                    return
                }
            }
            contract.properties = params
            
            if (!contract.hasErrors() && contract.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'contract.label', default: 'Contract'), contract.id])}"
                redirect(action: "show", id: contract.id)
            }
            else {
                render(view: "show", model: [contract: contract])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def contract = Contract.get(params.id)
        if (contract) {
            try {
                contract.delete(flush: true)
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
     * Registers a user log in from gui.
     */
    def addLogin = {
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
        def contract = Contract.get(params.id)
        if (contract) {
            if(contract.customer.amountDue>0){
                def payment = new Payment(amount:contract.amountDue,paymentDate:new Date(),paymentMethod:Payment.PM_DIRECT_DEBIT,customer:contract.customer).save()               
                log.debug "added payment ${payment} to customer ${contract.customer}"
                paymentService.calculatePayments(Contract.get(params.id))
            }
        }
        redirect(action: "show",id:params.id)
    }
    def calculatePayments = {
        paymentService.calculatePayments(Contract.get(params.id))
        flash.message = "${message(code: 'contract.calculatePayments.recalculated', args: [message(code: 'contract.label', default: 'Contract recalculated'), params.id])}"
        redirect(action: "show",id:params.id)
    }

    def dtaus ={
        log.debug "dtaus called..."
        // def hql = "select sum(amountGross) as amount, year(contractStart)||' '||month(contractStart) "
        def hql="from le.space.Customer  c "
        //  hql+=" left join c.customer cu "
        hql+=" where c.bankAccount.directDebitPermission=true "
        hql+= "and c.amountDue>0 "
        hql+= "order by c.amountDue desc"

        def hparams = []
        def contractList = Contract.executeQuery(hql,hparams)

        //FileOutputStream fos = new FileOutputStream("/Users/nico/Desktop/dtaus")
        ByteArrayOutputStream fout = new ByteArrayOutputStream();
        de.jost_net.OBanToo.Dtaus.DtausDateiWriter dtausDateiWriter = new DtausDateiWriter(fout);

        //Jetzt wird der ASatz gefüllt und geschrieben:
        dtausDateiWriter.setAGutschriftLastschrift("LK");
        dtausDateiWriter.setABLZBank(86055592);
        dtausDateiWriter.setAKundenname("Le Space UG");
        dtausDateiWriter.setAKonto(1100880298);
        dtausDateiWriter.writeASatz();

        //Ab hier werden die eigentlichen Zahlungssätze erstellt:
        contractList.each{
            log.debug "dtaus customer.id: ${it.id} ${it.bankAccount.accountOwner}"
            dtausDateiWriter.setCBLZEndbeguenstigt(new Long(it.bankAccount.bankNo).longValue());
            dtausDateiWriter.setCKonto(new Long(it.bankAccount.accountNo).longValue());
            dtausDateiWriter.setCTextschluessel(CSatz.TS_LASTSCHRIFT_EINZUGSERMAECHTIGUNGSVERFAHREN);
            dtausDateiWriter.setCInterneKundennummer(it.id);
            dtausDateiWriter.setCBetragInEuro(it.amountDue);
            dtausDateiWriter.setCName(it.bankAccount.accountOwner); //it.bankAccount.accountOwner
            dtausDateiWriter.addCVerwendungszweck("Le Space UG");
            dtausDateiWriter.addCVerwendungszweck("Coworking Schreibtisch V.Nr.:"+contractService.getContractsOfCustomer(it)[0]);
            //dtausDateiWriter.addCVerwendungszweck("Vertr. Nr."+it.id);
            dtausDateiWriter.writeCSatz();
        }

        //E-Satz schreiben = Ende einer logischen Datei.
        dtausDateiWriter.writeESatz();


        dtausDateiWriter.close();

        response.setHeader("Content-disposition", "attachment; filename=dtaus");
        response.contentType = "application/dtaus"
        //response.characterEncoding = "UTF-8"
        response.outputStream << fout.toByteArray() //reportDef.contentStream.toByteArray()

        // render 'bla'
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

        hql="from le.space.Customer  c "
        //  hql+=" left join c.customer cu "
        hql+=" where c.bankAccount.directDebitPermission=true "
        hql+= "and c.amountDue>0 "
        hql+= "order by c.amountDue desc"

        hparams = []
        def currentDueContracts = Contract.executeQuery(hql,hparams)
        [
            revenueByMonth: revenueByMonth,
            revenueByMonthOrderByDateDesc:revenueByMonthOrderByDateDesc,
            revenueByCustomer:revenueByCustomer,
            loginsByMonthYear:loginsByMonthYear,
            loginsByDate:loginsByDate,
            currentDueContracts:currentDueContracts
        ]
    }
}
