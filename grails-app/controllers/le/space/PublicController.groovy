package le.space

class PublicController {

    def index = {     
        log.debug " registration called..."
        [contract:new Contract(), shiroUser: new ShiroUser(), customer: new Customer(), bodyId:"anmeldung",slogan: "Jetzt anmelden und Fensterplätze sichern! :-)"]
    }

    // collect main data
    def step1 = {

        log.debug " step 1 called"

        def contract = session.contract
        def customer = session.customer
        contract.customer = customer
        def shiroUser = session.shiroUser
        customer.addToShiroUsers(shiroUser)
        

        if(!contract.validate()){
            log.debug "contract has errors! ${contract}"
            customer.errors.allErrors.each {
                log.error it
            }
            flash.message = message(code: "contract.formErrors",args: [ "" ])
            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }

        if(!customer.validate()){
            log.debug "customer has errors! ${customer}"
            customer.errors.allErrors.each {
                log.error it
            }
            flash.message = message(code: "customer.formErrors",args: [ "" ])
            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }

        if(!shiroUser.validate()){
            log.debug "shiroUser has errors! ${shiroUser}"
            shiroUser.errors.allErrors.each {
                log.error it
            }
            flash.message = message(code: "shiroUser.formErrors",args: [ "" ])
            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }
        log.debug "contract:${contract}\nshiroUser:${shiroUser}\ncustomer:${customer}"
        [contract:contract,customer:customer,shiroUser:shiroUser]
    }

    // check payment method (add products to contract)
    def step2 = {

        log.debug " step 2 called ${params.email}"
        def contract = session.contract
        contract.properties = params

        def customer = contract.customer
        if(!customer)
        customer = new Customer()

        customer.properties = params
        session.customer = customer
        contract.customer = customer
        
        def shiroUser = new ShiroUser()
        shiroUser.properties = params
        shiroUser.username = params.email
        
        customer.addToShiroUsers(shiroUser)
        session.shiroUser = shiroUser
        
        params.products.each{
            contract.addToProducts(Product.get(it))
        }

        log.debug "${contract}\n${shiroUser}\n${customer}"

        if(!contract.validate()){
            log.debug "contract has errors!"
            customer.errors.allErrors.each {
                log.error it
            }
            flash.message = message(code: "contract.formErrors",args: [ "" ])
            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }
        
        if(!customer.validate()){
            log.debug "customer has errors!"
            customer.errors.allErrors.each {
                log.error it
            }
            flash.message = message(code: "customer.formErrors",args: [ "" ])
            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }

        if(!shiroUser.validate()){
            log.debug "shiroUser has errors!"
            shiroUser.errors.allErrors.each {
                log.error it
            }
            flash.message = message(code: "shiroUser.formErrors",args: [ "" ])
            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }

        if(contract.paymentMethod == 0)
        [render(view: "step3", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        log.debug "contract:${contract}\nshiroUser:${shiroUser}\ncustomer:${customer}"
        [contract:contract,customer:customer,shiroUser:shiroUser]
    }

    //display contract data
    def step3 = {
        log.debug "step 3 called"
        def contract = session.contract
        def customer = session.customer
        customer.properties = params
        session.customer = customer
        def shiroUser = session.shiroUser
        customer.addToShiroUsers(shiroUser)
        contract.customer = customer

        log.debug "contract:${contract}\nshiroUser:${shiroUser}\ncustomer:${customer}"

        [contract:contract,customer:customer,shiroUser:shiroUser]
    }

    //save contract
    def register = {
        log.debug "register called"

        def contract = session.contract
        def shiroUser = session.shiroUser
        shiroUser.addToRoles(ShiroRole.findByName("User"))
        def customer = session.customer

        customer.addToShiroUsers(shiroUser)
        contract.customer = customer

        log.debug "contract:${contract}\nshiroUser:${shiroUser}\ncustomer:${customer}"
        
        if(shiroUser.validate() && shiroUser.save() && customer.validate() && customer.save() && contract.validate() && contract.save() ){
            log.debug "no errors contract saved"
            
//            shiroUser.save()
            session.contract = contract

            /*            //log.debug "try to send email... "
            def senderEmail = "info@le-space.de"

            def sendFile = new le.space.java.sendfile(grailsApplication.config.grails.mail.host,grailsApplication.config.grails.mail.port.toString(),
            grailsApplication.config.grails.mail.username,
            grailsApplication.config.grails.mail.password,true,
            senderEmail,contract.email, g.message(code:'contract.email.subject'), g.message(code:'contract.email.emailText'))


            def params = "&imageUrl=${HelperTools.getServerAndContext(request)}/img/logo_LeSpace.gif&"+
            "_format=PDF&"+
            "_inline=false&"+
            "_file=contract&"+
            "jasperFile=contract&"+
            "_name=${g.message(code:'contract.contract')}_${contract?.id}"

            def url = le.space.HelperTools.getServerAndContext(request)+"/public/contract/"+contract?.id+"?"
            url = response.encodeURL(url)+params

            log.debug "url:"+url

            sendFile.addFile(readUrlBytes(url),"${g.message(code:'contract.contract')}_${contract?.id}")

            String sendError = sendFile.send()

            if(sendError==null)
            flash.message = message(code: "contract.emailSuccess",args: [ "${sendError}" ])
            else
            flash.message = message(code: "contract.emailFailed",args: [ "${sendError}" ])
             */
        }
        else{
            contract.errors.allErrors.each {
                log.error it
            }

            flash.message = message(code: "contract.formErrors",args: [ "" ])

            [render(view: "step1", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
        }

        log.debug "${contract}\n${shiroUser}\n${customer}"
        
        [contract:contract,customer:customer,shiroUser:shiroUser]
    }

    /**
     * Prints the Detail Report of a single Task
     */
    def contract = {
        //wenn request nicht vom localhost kommt. abbrechen (return null zurückgeben)
        log.info "try to print pdf!"
        chain(controller:"jasper", action:"index", model:[data:[session.contract,session.customer,session.shiroUser]],params:params)
    }


    def autoExtend = {

        def contract = session.contract

        log.debug "params.autoExtend: ${params.autoExtend}"

        if(params.autoExtend=='true')
        contract.autoExtend=true
        else
        contract.autoExtend=false

        [render(view: "_sum", model: [contract:contract])]
    }

    def optionsOfProduct = {

        def contract = new Contract()
        contract.properties=params
        log.debug "quantity: ${contract.quantity} ${params}"
        def p
        if(params.id && params.id!='0'){
            p = Product.get(params.id)
            contract.addToProducts(p)
            contract.calculateAmounts()
        }
        
        session.contract=contract
        log.debug "load options of product ${p}  params.id:${params.id}"

        def options = null

        session.options = []

        if(params.id)
        options = le.space.Product.findAll('from Product as p where p.option = ?', [p])

        session.options = options

        log.debug "found options ${options} ${session.contract} params.id:${params.id}"
        [contract:session.contract,options:options,product:p]
    }

    def addOption = {

        def contract = session.contract
        def productId = params.optionName.substring(7,params.optionName.length())
        log.debug "called addOption with optionName:Value: ${params.optionName} : ${params.optionValue} -->productId:${productId} to contract: ${contract}"
        session.options.each{
            log.debug "options in current session: ${session.options} ${it.id} ${productId}"
            if(it.id==productId.toLong()){
                if(params.optionValue=='true'){
                    log.debug "adding product ${it}"
                    contract.addToProducts(it)
                 
                }
                else{
                    log.debug "removing product ${it}"
                    contract.removeFromProducts(it)
                }
                contract.calculateAmounts()
            }
        }
        log.debug "contents of optionList  ${contract.products}"

        [render(view: "_sum", model: [contract:contract])]
    }

    def contractPdf = {
        
        if(params.id)
          session.contract = Contract.get(params.id)

        def contract = session.contract

        contract.products.each{
            log.debug it
        }

        log.info "contractPdf called. with ${contract} and products: ${contract.products} and customer: ${contract.customer} and users: ${contract.customer.shiroUsers}"
        chain(controller:"jasper", action:"index", model:[data:[contract]],params:params)
    }

    public byte[] readUrlBytes(String address) {

        log.debug "loading pdf... "+address

        byte[] byteReturn = null;
        URL theURL = null
        InputStream is = null
        try {

            def out = new ByteArrayOutputStream()
            out << new URL(address).openStream()
            byteReturn = out.toByteArray()

            log.debug "----------------------->byteReturn.length"+byteReturn.length

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        byteReturn;
    }

}