package le.space
//import org.apache.shiro.crypto.hash.Sha512Hash
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils

class ShiroUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [shiroUserInstanceList: ShiroUser.list(params), shiroUserInstanceTotal: ShiroUser.count()]
    }

    def create = {
        def shiroUserInstance = new ShiroUser()
        shiroUserInstance.properties = params
        return [shiroUserInstance: shiroUserInstance]
    }

    def save = {
        def shiroUserInstance = new ShiroUser(params)
        if (shiroUserInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.id])}"
            redirect(action: "show", id: shiroUserInstance.id)
        }
        else {
            render(view: "create", model: [shiroUserInstance: shiroUserInstance])
        }
    }

    def show = {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (!shiroUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            [shiroUserInstance: shiroUserInstance]
        }
    }

    def edit = {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (!shiroUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [shiroUserInstance: shiroUserInstance]
        }
    }

    def update = {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (shiroUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (shiroUserInstance.version > version) {
                    
                    shiroUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'shiroUser.label', default: 'ShiroUser')] as Object[], "Another user has updated this ShiroUser while you were editing")
                    render(view: "edit", model: [shiroUserInstance: shiroUserInstance])
                    return
                }
            }
            shiroUserInstance.properties = params
            if (!shiroUserInstance.hasErrors() && shiroUserInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.id])}"
                redirect(action: "show", id: shiroUserInstance.id)
            }
            else {
                render(view: "edit", model: [shiroUserInstance: shiroUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (shiroUserInstance) {
            try {
                shiroUserInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def shiroUserAdd = {
        log.debug "shiroUser add called... with contract id ${params.contract.id} "
        def contract
        def shiroUserInstance = new ShiroUser()

        shiroUserInstance.properties = params
        shiroUserInstance.username = shiroUserInstance.email
        if(params.password)
            shiroUserInstance.passwordHash = params.password

//        shiroUserInstance.passwordHash = new Sha512Hash(params.password).toHex()

        if (shiroUserInstance.validate() && shiroUserInstance.save()) {
            log.debug "shiroUser ${shiroUserInstance} saved... "
            shiroUserInstance.addToPermissions("*:*")
            shiroUserInstance.addToRoles(ShiroRole.findByName("User"))
            shiroUserInstance.save()
            contract = Contract.get(params.contract.id)
            log.debug "contract ${contract} "
            def customer = contract.customer
            customer.addToShiroUsers(shiroUserInstance)
            customer.save()
            log.debug "customer ${customer} saved... "
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.id])}"
        }
        else{
            log.debug "shiroUserInstance has errors!"
            shiroUserInstance.errors.allErrors.each {
                log.error it
            }
        }

        render(view: "_customerUsers", model: [contract: contract])
    }
    def shiroUserUpdate = {
        log.debug "shiroUser update called... with contract id ${params.contract.id} ${params.id} "
        def contract
        def shiroUserInstance = ShiroUser.get(params.id)

        shiroUserInstance.properties = params
        shiroUserInstance.username = shiroUserInstance.email

        if(params.password)
            shiroUserInstance.passwordHash = params.password

            //shiroUserInstance.passwordHash = new Sha512Hash(params.password).toHex()

        if (shiroUserInstance.validate() && shiroUserInstance.save()) {
            log.debug "shiroUser ${shiroUserInstance} saved... "
            shiroUserInstance.addToPermissions("*:*")
            shiroUserInstance.addToRoles(ShiroRole.findByName("User"))
            shiroUserInstance.save()
            contract = Contract.get(params.contract.id)
            log.debug "contract ${contract} "
            def customer = contract.customer
            customer.addToShiroUsers(shiroUserInstance)
            customer.save()
            log.debug "customer ${customer} saved... "
            flash.message = "${message(code: 'default.updated.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.username])}"
        }
        else{
            log.debug "shiroUserInstance has errors!"
            shiroUserInstance.errors.allErrors.each {
                log.error it
            }
        }

        render(view: "_customerUsers", model: [contract: contract])
    }
    def shiroUserRemove = {
        log.debug "shiroUser update called... with contract id ${params.contract.id} ${params.id} "
        def shiroUserInstance = ShiroUser.get(params.id)
        def contract = Contract.get(params.contract.id)
        if (shiroUserInstance && contract) {
            try {
                contract.customer.removeFromShiroUsers(shiroUserInstance)
                shiroUserInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.username])}"

            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"

            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])}"

        }
        render(view: "_customerUsers", model: [contract: contract])
    }

    //Changes the Password of a User
    def passwordChange = {

        log.debug "shiroUser.passwordChange called with shiroUser id ${params.id} ${params.passwordOld} ${params.passwordNewAgain} ${params.passwordNew}"

        def shiroUser = ShiroUser.get(params.id)

        if(params && params.passwordNew == params.passwordNewAgain){
            try{
                def authToken = new UsernamePasswordToken(shiroUser.username, params.passwordOld)
                SecurityUtils.subject.login(authToken)

                //Change Password here.
                //shiroUser.passwordHash = new Sha512Hash(params.passwordNew).toHex()

                shiroUser.passwordHash =  params.passwordNew
                shiroUser.save(flush:true)
                
                flash.message = message(code: "login.passwordChanged")
            }
            catch (AuthenticationException ex){
                log.info "Authentication failure for user '${shiroUser}'."
                flash.message = message(code: "login.failed.wrongPassword")
            }
        }
        else{
            flash.message = message(code: "login.failed.passwordDontMatch")
        }
        
        [shiroUser:shiroUser]
    }
}
