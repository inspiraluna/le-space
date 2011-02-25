package le.space
import org.joda.time.*
import org.joda.time.format.*

class LoginService implements  le.space.java.LoginServiceIf {
  
    static transactional = true
    def paymentService


    def createUser(ShiroUser shiroUser){

        if(shiroUser.validate()){
            log.debug "shiroUser valid: ${shiroUser.validate()} saving"
            shiroUser = shiroUser.save()
        }

        return shiroUser
    }

    def isCurrentContractOfUserValid(ShiroUser user){
        def contract = getLastContractOfUser(user)
        try{
            if(contract){
                paymentService.calculatePayments(contract)
                contract.calculateAmounts()
                contract.valid
            }
        }
        catch(Exception ex){log.debug "problem with calculation of contract..."}
        
    }

    /**
     * counts a login - but doesn't
     */
    def login(String id, String ipAddress, String macAddress) {

        def shiroUser = le.space.ShiroUser.get(id)
        log.debug "shiroUser:${shiroUser} userId:${id} valid:${isCurrentContractOfUserValid(shiroUser)}"

        if (shiroUser) {
            def login = new Login(user:shiroUser,ipAddress:ipAddress?ipAddress:null,macAddress:macAddress?macAddress:null,loginStart:new Date()).save()
            log.debug "login saved?: ${login}"
            def contract = getLastContractOfUser(shiroUser)
            if(contract)
            recalculateLoginsOfContract(contract)
        } // if shiroUser
    }

    /**
     * Recalculates all login countings of a conract based on its login objects
     * 1. get all logins of contract by duration (also check autoExtends and canceled conctracts)
     * 2. set found values
     * 3. save contract
     */
    def recalculateLoginsOfContract(Contract contractInstance){

        //ShiroUser.withNewSession{
        log.debug "Contract ${contractInstance}"
        //log.debug "has durationType: ${(contractInstance.getProducts()?.toArray())[0].durationType} (0=day 1=month)"

        contractInstance.loginDays = this.getDayLogins(contractInstance).size()
        log.debug "set loginDays of contract from ${contractInstance.loginDays} to ${contractInstance.loginDays}"

        log.debug "now update contract with allowedLoginDaysLeft with products allowedLoginsDay * quantity - loginDays!"
        if(contractInstance.getProducts() && (contractInstance.getProducts().toArray())[0].allowedLoginDays!=0){ //(contractInstance.getProducts().toArray())[0].durationType==Product.DUR_DAY){
            log.debug "allowedLoginDays of Product is ${(contractInstance.getProducts().toArray())[0].allowedLoginDays}"
            contractInstance.allowedLoginDaysLeft = (contractInstance.getProducts().toArray())[0].allowedLoginDays*contractInstance.quantity - contractInstance.loginDays
        }
        else{
            log.debug "allowedLoginsDay of product is 0"
            contractInstance.allowedLoginDaysLeft = 0
        }

        log.debug "login was counted. allowedLoginDayLeft now:${contractInstance.allowedLoginDaysLeft} and loginDays now: ${contractInstance.loginDays}"
        contractInstance.lastLogin = new Date()
        contractInstance.save()
        //}
    }


    /**
     * Get last Contract of User
     */
    def getLastContractOfUser(ShiroUser shiroUser){
        
        // Contract.withNewSession{
        //0. find last active contract of user
        def hql="select co from le.space.Contract  co "
        hql+="left join co.customer cu "
        hql+="left join cu.shiroUsers u "
        hql+="WHERE u=:shiroUser "
        hql+="ORDER BY co.contractStart desc"

        def hparams = [shiroUser:shiroUser]

        def contractList = Contract.executeQuery(hql,hparams)
        log.debug "contractListSize of shiroUser ${shiroUser} is ${contractList.size()}"

        contractList[0]
        //}
    }

    /**
     * Gets all days of a contract with at least 1 login - also return shiroUser
     */
    def getDayLogins(Contract contractInstance){

        log.debug "look for all logins in between contract start and contract stop / cancelationDate and count all days"
        def contractStartTemp = contractInstance.contractStart
        if(contractInstance.autoExtend)
        contractStartTemp = new DateTime(new DateTime().year().get(),new DateTime().monthOfYear().get(),contractInstance.contractStart.getDay(),0,0,0,0).toDate()

        def hparams = [contractStart:contractStartTemp]
        def hql = "select date(l.loginStart), l.user as user from le.space.Login l "
        hql+= "where l.loginStart >= :contractStart "

        if(contractInstance.cancelationDate){
            hql+= "and (l.loginStart <= :cancelationDate) "
            hparams.put("cancelationDate",contractInstance.cancelationDate)
        }
        else if(contractInstance.contractEnd){
            hql+= "and (l.loginStart <= :contractEnd) "
            hparams.put("contractEnd",contractInstance.contractEnd)
        }
        def shiroUsers = contractInstance.customer.getShiroUsers()

        if(shiroUsers)
        hql+=" and ("

        int i = 0
        shiroUsers.toArray().each{
            if(i>0)
            hql+=" or "
            hql+="l.user=:shiroUser"+i
            hparams.put("shiroUser"+i,it)
            i++
        }
        
        if(shiroUsers)
        hql+= ") "

        hql+= "group by date(l.loginStart), l.user  "
        hql+= "order by date(l.loginStart) desc"
        log.debug hql +" contractStart: ${contractStartTemp}"
        // int loginDays = Contract.executeQuery(hql,hparams).size()
        def loginList = Login.executeQuery(hql,hparams)
    }
}

