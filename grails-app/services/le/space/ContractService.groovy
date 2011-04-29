package le.space
import org.apache.shiro.SecurityUtils
class ContractService {

    static transactional = true

    def addContract(Contract contract, Customer customer, ShiroUser shiroUser, BankAccount bankAccount, java.util.HashSet products){

        boolean okey = false

        log.debug "contract:${contract}\n shiroUser:${shiroUser}\n customer:${customer}\n bankAccount:${bankAccount}"
        shiroUser.save(flush:true)

        if(!SecurityUtils.subject.hasRole("User"))
            shiroUser.addToRoles(ShiroRole.findByName("User"))
      
        if(shiroUser.save(flush:true))
            okey = true

        if(customer.save(flush:true))
            okey = true

        if(!customer.shiroUsers.contains(shiroUser))
        customer.addToShiroUsers(shiroUser)


        if(customer.save(flush:true))
            okey = true

        if(bankAccount.save(flush:true))
            okey = true

        contract.customer = customer
        contract.products = products
        
        if(contract.save(flush:true))
            okey = true
            
        log.debug "no errors contract,customer,shiroUser and bankAccount saved"
        
        okey
    }

    def getContractsOfUsername(String username) {

        try {
            def hql="select co from le.space.Contract  co "
            hql+="inner join co.customer cu "
            hql+="inner join cu.shiroUsers u "
            hql+="WHERE u.username=:username "
            hql+="ORDER BY co.contractStart desc"

            def hparams = [username:username]

            Contract.executeQuery(hql,hparams)

        }catch(Exception ex){ log.debug "problem with user: ${username}" }
    }


    def getContractsOfCustomer(Customer cu) {
        
        def hql="select co from le.space.Contract  co "
        hql+="inner join co.customer cu "
        hql+="WHERE cu=:customer "
        hql+="ORDER BY co.contractStart desc"

        def hparams = [customer:cu]

        Contract.executeQuery(hql,hparams)
    }

}
