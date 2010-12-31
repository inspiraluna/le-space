package le.space
import org.apache.shiro.SecurityUtils
class ShiroUser {

    String username
    String passwordHash

    String salutation
    String firstname
    String lastname
    String email

    Date birthday   
    String telMobile

    String occupation
    String twitterName
    String facebookName

    boolean optOutIamHereFunction = false

    Date dateCreated = new Date()
    Date dateModified = new Date()
    ShiroUser createdBy
    ShiroUser modifiedBy


    static hasMany = [roles: ShiroRole, permissions: String,logins: Login]

    static constraints = {
        username(nullable: false, blank: false, unique:true)
        passwordHash(nullable:true,blank:true)

        salutation(nullable:true,blank:true)
        firstname(nullable:false,blank:false)
        lastname(nullable:false,blank:false)
        email(nullable:false,email:true,blank:false)
        
        birthday(nullable:true,blank:true)
        telMobile(nullable:true,blank:true)

        occupation(nullable:true,blank:true)
        twitterName(nullable:true,blank:true)
        facebookName(nullable:true,blank:true)
        optOutIamHereFunction()
        dateCreated(nullable:true,blank:true)
        dateModified(nullable:true,blank:true)
        createdBy(nullable:true,blank:true)
        modifiedBy(nullable:true,blank:true)
    }
    
    def beforeInsert = {
        dateCreated = new Date()
        dateModified = new Date()
        if(!username)
            username = email
        try { //during startup no securityManager!
            createdBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
        }catch(Exception ex){createdBy=ShiroUser.get(1)}
    }

    def beforeUpdate = {
        dateModified = new Date()
        if(!username)
            username = email
        try{ //during startup no securityManager!
            modifiedBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
        }catch(Exception ex){modifiedBy=ShiroUser.get(1)}
    }

    String toString(){
        "(${username}) ${salutation} ${firstname} ${lastname} ${email} ${birthday} ${telMobile} ${occupation}"
    }
}
