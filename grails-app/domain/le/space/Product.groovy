package le.space

class Product {
	
    static final int DUR_DAY = 0
    static final int DUR_MONTH = 1

    static constraints = {
        productNo(nullable:false)
        name(nullable:false,blank:false)
        description(nullable:true,blank:true)
        conditions(nullable:true,blank:true)
        priceNet(nullable:false)
        priceVAT(nullable:false)
        priceGross(nullable:false)
        vat(nullable:false)
        option(nullable:true)
        durationType()
        duration()
        autoExtendPossible()
        validFrom(nullable:false,blank:false)
        validTo(nullable:true,blank:true)
    }

    String productNo
    String name
    String description
    String conditions

    double priceNet
    double priceVAT
    double priceGross
    double vat
    Product option //this product acts as an option of another product
    int durationType = Product.DUR_DAY
    int duration=1

    int allowedLoginDays = 1 //how many different days the user can login (10 times with a flex desk 10 days in 3 monts, 12 times with a flex desk 12 times)

    Date validFrom = new Date() //this product is valid from this date until validTo
    Date validTo //this product is valid from the date validFrom until this date
    boolean publicProduct = false
	
    boolean autoExtendPossible



    def calculate(){
        priceGross = (priceNet+(priceNet*vat/100)).round(2)
        priceVAT = (priceNet*vat/100).round(2)
    }

    def beforeInsert = {
        log.debug "beforeInsert: calculating priceGross & priceVAT "
        calculate()

    }

    def beforeUpdate = {
        log.debug "beforeUpdate: calculating priceGross & priceVAT "
        calculate()
    }

    def onLoad = {
        //calculate()

        //log.debug "I'm loaded"
    }


    String toString(){
		" ${name}  "
    }
}
