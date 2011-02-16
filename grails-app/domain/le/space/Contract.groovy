package le.space

import org.joda.time.*
import org.joda.time.format.*
import org.apache.shiro.SecurityUtils

class Contract {

    def loginService
    def paymentService

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

    Date cancelationDate
    Date dateCreated = new Date()
    Date dateModified = new Date()
    ShiroUser createdBy
    ShiroUser modifiedBy
    
    def toolService
   	
    static transients = ["loginService"]

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
        
        def val = ""
        this.getProducts().each{
            //log.debug it
            // val+=toolService.getMessage('contract.product.'+it.id)+" (€ "+toolService.formatNumber(it.priceNet)+" netto)\n"
            val+=it.name+" (€ "+toolService.formatNumber(it.priceNet)+" netto)\n"
        }
        selectedProducts = val
     
        if(!autoExtend && this.getProducts()){
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

        this.getProducts().each{
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
             
    }

    def beforeInsert = {

        dateCreated = new Date()
        dateModified = new Date()
        try { //during startup no securityManager!
            createdBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
        }catch(Exception ex){createdBy=ShiroUser.get(1)}
        allowedLoginDaysLeft=getProducts()?getProducts().toArray()[0].allowedLoginDays*quantity:0
        log.debug "beforeInsert"
        calculateAmounts()
    }

    def beforeUpdate = {
        dateModified = new Date()
        try { //during startup no securityManager!
            modifiedBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
        }catch(Exception ex){createdBy=ShiroUser.get(1)}
        log.debug "beforeUpdate"
        calculateAmounts()
    }
/**
    def afterLoad = {
        log.debug "afterload"
        calculateAmounts()
    }
  */
    def afterInsert = {
        // paymentService.calculatePayments(this)
    }

    def afterUpdate = {

        //paymentService.calculatePayments(this)
    }

    String toString(){
        "${id} ${contractStart} ${contractEnd} ${paymentMethod} ${amountGross} ${amountNet}"
    }
}
