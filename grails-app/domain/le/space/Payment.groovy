package le.space

class Payment {

    
    static final int PM_CASH = 0
    static final int PM_DIRECT_DEBIT = 1
    static final int PM_PAYPAL = 2
    static final int PM_BANK_TRANSFER = 3

    double amount
    Date paymentDate
    int paymentMethod = 0 //BAR=0

    Contract contract
    
    
    static belongsTo = Contract


    static constraints = {
        
    }

    String toString(){
    " amount: ${amount} \n"+
    " paymentDate:${paymentDate} \n"
    }


}
