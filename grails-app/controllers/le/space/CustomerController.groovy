package le.space
import org.apache.shiro.SecurityUtils
class CustomerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def loginService 
    def contractService

    def customerContracts = {
        log.debug "customerContracts"

        def username = SecurityUtils.getSubject().principal
        // def shiroUser = ShiroUser.findByUsername(username)
        def contractList = contractService.getContractsOfUsername(username)
        def contract = contractList[0]
        [number:false,contract:contract,
            contractList:contractList]
    }
    
    def bankAccount = {
        log.debug "updateBankAccount"
        def bankAccountInstance = BankAccount.get(params.id)
        if (bankAccountInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bankAccountInstance.version > version) {
                    bankAccountInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'bankAccount.label', default: 'BankAccount')] as Object[], "Another user has updated this BankAccount while you were editing")
                }
            }
            bankAccountInstance.properties = params
            if (!bankAccountInstance.hasErrors() && bankAccountInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'bankAccount.label', default: 'BankAccount'), bankAccountInstance.id])}"
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bankAccount.label', default: 'BankAccount'), params.id])}"      
        }
        [contract:Contract.get(params.contract.id)]
    }

    def customerData = {
        log.debug "customerData called!"
        def customerInstance = Customer.get(params.id)
        def contract = Contract.get(params.contract.id)
        if (customerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerInstance.version > version) {                  
                    customerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customer.label', default: 'Customer')] as Object[], "Another user has updated this Customer while you were editing")
                    render(view: "edit", model: [customerInstance: customerInstance])
                    return
                }
            }
            customerInstance.properties = params
            if (!customerInstance.hasErrors() && customerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance])}"
                log.debug flash.message
                render(view: "customerData", model: [customerInstance: customerInstance,contract:contract])
                
            }
            else {
                render(view: "customerData",  model: [customerInstance: customerInstance,contract:contract])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            render(view: "customerData", model: [contract: contract])
        }
    }
    
    def addContract = {

        def contract = new Contract(params)
        def customer = Customer.findById(params.customer.id)
        log.debug "adding new contract to customer ${customer}"

        contract.customer = customer
        contract.products =  session.products
        if (contract.save()) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'contract.label', default: 'Contract'), contract.id])}"
        }
        else{
            contract.errors.allErrors.each {
                log.error it
            }
        }
        render(view: "addContract", controller:"customer", model: [contract: contract] )
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count()]
    }

    def create = {
        def customerInstance = new Customer()
        customerInstance.properties = params
        return [customerInstance: customerInstance]
    }

    def save = {
        def customerInstance = new Customer(params)
        if (customerInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])}"
            redirect(action: "show", id: customerInstance.id)
        }
        else {
            render(view: "create", model: [customerInstance: customerInstance])
        }
    }

    def show = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerInstance: customerInstance]
        }
    }

    def edit = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerInstance: customerInstance]
        }
    }

    def update = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerInstance.version > version) {
                    
                    customerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customer.label', default: 'Customer')] as Object[], "Another user has updated this Customer while you were editing")
                    render(view: "edit", model: [customerInstance: customerInstance])
                    return
                }
            }
            customerInstance.properties = params
            if (!customerInstance.hasErrors() && customerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])}"
                redirect(action: "show", id: customerInstance.id)
            }
            else {
                render(view: "edit", model: [customerInstance: customerInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            try {
                customerInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }
}
