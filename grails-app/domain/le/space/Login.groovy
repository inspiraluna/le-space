package le.space

class Login {

    ShiroUser user
    String ipAddress = ""
    String macAddress = ""
    Date loginStart = new Date()

    static belongsTo = Contract

    static constraints = {
        user(nullable:true,blank:true)
        ipAddress(nullable:true,blank:true)
        macAddress(nullable:true,blank:true)
        loginStart(nullable:false,blank:false)
    }

    String toString(){
        " user: ${user} "+" loginStart: ${loginStart} "+" macAddress: ${macAddress} "+
        " ipAddress:${ipAddress}"
    }

}
