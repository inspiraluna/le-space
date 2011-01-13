package le.space

class Payment {
    
    static final int PM_CASH = 0
    static final int PM_DIRECT_DEBIT = 1
    static final int PM_PAYPAL = 2
    static final int PM_BANK_TRANSFER = 3

    double amount
    Date paymentDate
    int paymentMethod = 0 //BAR=0

    Customer customer
    
    static belongsTo = Customer

    static constraints = {
        amount(nullable:false,blank:false)
        amount(nullable:false,blank:false)
        paymentDate(nullable:false,blank:false)
        customer(nullable:false,blank:false)
    }

    String toString(){
    " amount: ${amount} \n"+
    " paymentDate:${paymentDate} \n"
    }
}
