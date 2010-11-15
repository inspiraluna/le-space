package le.space

class BankAccount {

    boolean directDebitPermission = false
    String accountOwner
    String accountNo
    String bankNo
    String bankName
    String IBANNo
    String BICNo

    static belongsTo = [Customer]

    static constraints = {
        accountOwner(nullable:true,blank:true)
        accountNo(nullable:true,blank:true)
        bankNo(nullable:true,blank:true)
        bankName(nullable:true,blank:true)
        IBANNo(nullable:true,blank:true)
        BICNo(nullable:true,blank:true)
        directDebitPermission()
    }

    String toString(){
        "${bankName} ${bankNo} ${accountOwner} ${directDebitPermission}"
    }
}
