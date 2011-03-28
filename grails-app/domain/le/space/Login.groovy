package le.space

import org.joda.time.*
import org.joda.time.format.*

class Login {

    def loginService

    //ShiroUser user
    String ipAddress = ""
    String macAddress = ""
    Date loginStart = new Date()

    static belongsTo = [user:ShiroUser]

    static transients = ["loginService"]
    
    static constraints = {
        ipAddress(nullable:true,blank:true)
        macAddress(nullable:true,blank:true)
        loginStart(nullable:false,blank:false)
    }

    String toString(){
        " user:${user} loginStart: ${loginStart} "+" macAddress: ${macAddress} "+
        " ipAddress:${ipAddress}"
    }

    /**
     * 0. find last contract
     * 1. update loginDays of contract
     * 2. udpate loginDaysleft of contract
     */
   // def afterInsert(){


       
    //}

}
