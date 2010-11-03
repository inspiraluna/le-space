package le.space

class LoginController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [loginInstanceList: Login.list(params), loginInstanceTotal: Login.count()]
    }

    def create = {
        def loginInstance = new Login()
        loginInstance.properties = params
        return [loginInstance: loginInstance]
    }

    def save = {
        def loginInstance = new Login(params)
        if (loginInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'login.label', default: 'Login'), loginInstance.id])}"
            redirect(action: "show", id: loginInstance.id)
        }
        else {
            render(view: "create", model: [loginInstance: loginInstance])
        }
    }

    def show = {
        def loginInstance = Login.get(params.id)
        if (!loginInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'login.label', default: 'Login'), params.id])}"
            redirect(action: "list")
        }
        else {
            [loginInstance: loginInstance]
        }
    }

    def edit = {
        def loginInstance = Login.get(params.id)
        if (!loginInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'login.label', default: 'Login'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [loginInstance: loginInstance]
        }
    }

    def update = {
        def loginInstance = Login.get(params.id)
        if (loginInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (loginInstance.version > version) {
                    
                    loginInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'login.label', default: 'Login')] as Object[], "Another user has updated this Login while you were editing")
                    render(view: "edit", model: [loginInstance: loginInstance])
                    return
                }
            }
            loginInstance.properties = params
            if (!loginInstance.hasErrors() && loginInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'login.label', default: 'Login'), loginInstance.id])}"
                redirect(action: "show", id: loginInstance.id)
            }
            else {
                render(view: "edit", model: [loginInstance: loginInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'login.label', default: 'Login'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def loginInstance = Login.get(params.id)
        if (loginInstance) {
            try {
                loginInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'login.label', default: 'Login'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'login.label', default: 'Login'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'login.label', default: 'Login'), params.id])}"
            redirect(action: "list")
        }
    }
}
