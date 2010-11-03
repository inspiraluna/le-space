package le.space
import org.apache.shiro.SecurityUtils

class Customer {
    
    String company
    String addressLine1
    String addressLine2
    String zip
    String city
    String country
    
    String tel1
    String fax

    String url
    String publicationHTML
    String salutation
    String firstname
    String lastname
    String email

    boolean allowPublishNameOnWebsite = true
    boolean directDebitPermission = false

    String accountOwner
    String accountNo
    String bankNo
    String bankName
    String IBANNo
    String BICNo

    Date dateCreated = new Date()
    Date dateModified = new Date()
    ShiroUser createdBy
    ShiroUser modifiedBy

    static hasMany = [shiroUsers: ShiroUser, contracts:Contract]

    public getSalutation(){
        if(getShiroUsers() && getShiroUsers().size()>0)
        getShiroUsers().toArray()[0].salutation
        else
        ""
    }

    public getFirstname(){
        if(getShiroUsers() && getShiroUsers().size()>0)
        getShiroUsers().toArray()[0].firstname
        else
        ""
    }

    public getLastname(){
        if(getShiroUsers() && getShiroUsers().size()>0)
        getShiroUsers().toArray()[0].lastname
        else
        ""
    }
    
    public getEmail(){
        if(getShiroUsers() && getShiroUsers().size()>0)
        getShiroUsers().toArray()[0].email
        else
        ""
    }

    static transients = ["publicationHTML","salutation","firstname","lastname","email"]

    static constraints = {
        company(nullable:true,blank:true)
        addressLine1(nullable:false,blank:false)
        addressLine2(nullable:true,blank:true)
        zip(nullable:false,blank:false)
        city(nullable:false,blank:false)
        country(nullable:true,blank:true)
       
        tel1(nullable:true,blank:true)       
        fax(nullable:true,blank:true)
        url(nullable:true,blank:true)

        allowPublishNameOnWebsite()
        accountOwner(nullable:true,blank:true)
        accountNo(nullable:true,blank:true)
        bankNo(nullable:true,blank:true)
        bankName(nullable:true,blank:true)
        IBANNo(nullable:true,blank:true)
        BICNo(nullable:true,blank:true)
        directDebitPermission()

        dateCreated(nullable:true,blank:true)
        dateModified(nullable:true,blank:true)
        createdBy(nullable:true,blank:true)
        modifiedBy(nullable:true,blank:true)
    }



    def beforeInsert = {
        dateCreated = new Date()
        dateModified = new Date()
        createdBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
    }

    def beforeUpdate = {
        dateModified = new Date()
        modifiedBy = SecurityUtils.getSubject().principal?ShiroUser.findByUsername(SecurityUtils.getSubject().principal):null
    }

    def afterLoad = {

        def html = "<hr /><p>"
        html+="${shiroUsers.toArray()[0].firstname} ${shiroUsers.toArray()[0].lastname} "
        if(shiroUsers.toArray()[0].occupation)
        html+="- (${shiroUsers.toArray()[0].occupation})"
        if(company)
            html+="- ${company},"
        if(city)
        html+=" (${city})"
        if(url && !url.startsWith("http://"))
        url="http://"+url
        if(url)
        html+=" <a href='${url}' class='extern' target='_blank'>${url}</a></p>"
        publicationHTML = html;
        
    }
    String toString(){
        "${company} ${addressLine1} ${addressLine2} ${zip} ${country} ${tel1} ${fax} ${url} directDebitPermission:${directDebitPermission}"
    }

}