package le.space
import org.apache.shiro.crypto.hash.Sha512Hash

class ShiroUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [shiroUserInstanceList: ShiroUser.list(params), shiroUserInstanceTotal: ShiroUser.count()]
    }
    
    def add = {
        log.debug "shiroUser add called... with contract id ${params.contract.id} "
        def contractInstance
        def shiroUserInstance = new ShiroUser()

        shiroUserInstance.properties = params
        shiroUserInstance.username = shiroUserInstance.email
        shiroUserInstance.passwordHash =  new Sha512Hash(params.password).toHex()

        if (shiroUserInstance.validate() && shiroUserInstance.save()) {
            log.debug "shiroUser ${shiroUserInstance} saved... "
            shiroUserInstance.addToPermissions("*:*")
            shiroUserInstance.addToRoles(ShiroRole.findByName("User"))
            shiroUserInstance.save()
            contractInstance = Contract.get(params.contract.id)
            log.debug "contractInstance ${contractInstance} "
            def customer = contractInstance.customer
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

        render(view: "_customerUsers", model: [contractInstance: contractInstance])
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
}
