package le.space

import org.joda.time.*
import org.joda.time.format.*
import org.apache.shiro.SecurityUtils

class Contract {

    def loginService

    static final int PM_CASH = 0
    static final int PM_DIRECT_DEBIT = 1
    static final int PM_PAYPAL = 2
    static final int PM_BANK_TRANSFER = 3

    Customer customer
    String conditions

    double quantity = 1 //default 1 (how many persons / per contract)

    int loginDays = 0

    Date lastLogin

    int allowedLoginDaysLeft = 1
    int paymentMethod = 0 //BAR=0,

    Date contractStart = new Date()
    Date contractEnd //if contractEnd is null - no contract is not ending.. which means its going to autoExtend automatically after end of month / end of visit times

    boolean autoExtend = false //contract extends automatically by 1 month

    String selectedProducts
    
    boolean valid
    boolean paid

    double amountGross = 0
    double amountNet = 0
    double amountVAT = 0
    double amountPaid = 0
    double amountDue = 0
    double amountTotal = 0

    Date cancelationDate = new Date()
    Date dateCreated = new Date()
    Date dateModified = new Date()
    ShiroUser createdBy
    ShiroUser modifiedBy
    
    def toolService
   	
    static transients = ["selectedProducts","loginService"]

    static hasMany = [products: Product]
    static belongsTo = [Customer]

    static constraints = {

        conditions(nullable:true,blank:true)        
        paymentMethod(nullable:false,inList:[0,1,2,3])
        contractStart(nullable:false,blank:false)
        contractEnd(nullable:true,blank:true)
        autoExtend()
        valid(nullable:true,blank:true)
        cancelationDate(nullable:true,blank:true)
        dateCreated(nullable:true,blank:true)
        dateModified(nullable:true,blank:true)
        createdBy(nullable:true,blank:true)
        modifiedBy(nullable:true,blank:true)
        lastLogin(nullable:true)
        
    }

    def calculateAmounts(){
        
        if(this.id){
            def sum = Contract.executeQuery("select sum(amount) from le.space.Payment p where p.customer.id=:id",[id:this.customer.id])
            amountPaid = (sum==null || sum[0]==null)?0:sum[0]

            //Collect all contracts
            amountTotal = 0
            def l = Contract.findByCustomer(this.customer)
            l.each{
                //if contract entends automatically calculate all months gone sofar and mulitplay with amountGross for amountTotal!
                if(it.autoExtend){
                    int monthsGone = Months.monthsBetween(
                        new DateTime(it.contractStart).withTime(0,0,0,0),
                        cancelationDate?new DateTime(it.cancelationDate).withTime(0,0,0,0):new DateTime().withTime(23,59,59,999)).getMonths()
                    amountTotal += it.amountGross*(monthsGone)
                }
                amountTotal += it.amountGross
            }
        }

        def val = ""
        getProducts().each{
            val+=toolService.getMessage('contract.product.'+it.id)+" (€ "+toolService.formatNumber(it.priceNet)+" netto)\n"
        }
        selectedProducts = val
     
        if(!autoExtend && getProducts()){
            def ld = new DateTime(contractStart).withTime(23,59,59,999)

            if(getProducts()?.size()>0 && getProducts().toArray()[0].durationType==Product.DUR_MONTH)
            ld = ld.plusMonths(getProducts().toArray()[0].duration)
            if(getProducts()?.size()>0 && getProducts().toArray()[0].durationType==Product.DUR_DAY)
            ld = ld.plusDays(getProducts().toArray()[0].duration)
            ld = ld.minusDays(1)		
            contractEnd = ld.toDate()
        }
        if(autoExtend)
        contractEnd = null

        //calculating amountNet
        double aGross = 0.00
        double aNet = 0.00
        double aVAT = 0.00

        getProducts().each{
            double iNet = it.priceNet*quantity
            aNet+=iNet
            aGross+=iNet+(iNet*it.vat/100)
            aVAT+=iNet*it.vat/100
            // log.debug "-->currentProduct: ${it.name} priceNet:${it.priceNet} priceGross:${it.priceGross} amount:${it.priceVAT}"
        }
        if(!customer?.reverseChargeSystem){
            amountNet = aNet.round(2)
            amountVAT  = aVAT.round(2)
            amountGross = aGross.round(2)

        }
        else{
            amountNet = aNet.round(2)
            amountVAT  = 0.00
            amountGross = amountNet
        }

        //automatisch verlängernde Verträge heraussuchen und anzahl der noch nicht bezahlten Monate heraussuchen und mit Vertragspreis multiplizieren.
        boolean autoExtendPaid = false
       
        //log.debug "autoExtend:${autoExtend} amountPaid:${amountPaid} monthsGone:${monthsGone} amountGross*monthsGone:${amountGross*monthsGone}"
        if(autoExtend && amountPaid >=amountTotal){
            autoExtendPaid = true
        }
        amountDue = amountTotal - amountPaid
        
        if((!autoExtend && amountPaid >=amountTotal) || (autoExtend && autoExtendPaid))
        paid = true
        else
        paid = false

        boolean tmpValid = false

        if(autoExtend && autoExtendPaid && new DateTime(cancelationDate).withTime(0,0,0,0).toDate().getTime()>=new Date().getTime() && new DateTime(contractStart).withTime(0,0,0,0).toDate().getTime()<=new Date().getTime() && allowedLoginDaysLeft>-1){
            tmpValid = true
        }

        if(!autoExtend && paid && new DateTime(contractStart).withTime(0,0,0,0).toDate().getTime()<=new Date().getTime() && new DateTime(contractEnd).withTime(23,59,59,999).toDate().getTime()>=new Date().getTime() && allowedLoginDaysLeft>-1){
            tmpValid  = true
        }

        if(tmpValid!=valid){
            log.debug "contract${id} is not ${valid} anymore. "
            valid = tmpValid
            toolService.persistContractAgain(id)
        }      
    }

    def beforeInsert = {

        dateCreated = new Date()
        dateModified = new Date()
        try { //during startup no securityManager!
            createdBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
        }catch(Exception ex){createdBy=ShiroUser.get(1)}
        allowedLoginDaysLeft=getProducts()?getProducts().toArray()[0].allowedLoginDays*quantity:0
        calculateAmounts()
    }

    def beforeUpdate = {
        dateModified = new Date()
        try { //during startup no securityManager!
            modifiedBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
        }catch(Exception ex){createdBy=ShiroUser.get(1)}
  
        calculateAmounts()
    }

    def afterLoad = {
      // loginService.recalculateLoginsOfContract(this)
    }

    String toString(){
        "${id} ${contractStart} ${contractEnd} ${paymentMethod} ${amountGross} ${amountNet}"
    }
}
