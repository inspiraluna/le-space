package le.space
//import org.apache.shiro.crypto.hash.Sha512Hash
import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef
import org.apache.shiro.SecurityUtils
import com.lowagie.text.*
import com.lowagie.text.pdf.*
import java.security.cert.Certificate;
import java.security.PrivateKey;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.Security;
import java.security.cert.CertStore;
import java.security.cert.CollectionCertStoreParameters;
import java.security.cert.X509Certificate;


class PublicController {

    def jasperService
    def mailService
    def contractService
    
    def index = {

        log.debug " registration called..."
        
        session.contract=new Contract()
        session.bankAccount = new BankAccount()
        session.customer = new Customer()
        session.products = null
        session.shiroUser = new ShiroUser()

        [contract:new Contract(), shiroUser: new ShiroUser(), customer: new Customer(), bodyId:"anmeldung",slogan: "Jetzt anmelden und Fensterplätze sichern! :-)"]
    }

    // collect main data
    def step1 = {

        log.debug " step 1 called"

        def contract = session.contract
        def customer = session.customer
        def products = session.products
        def bankAccount = session.bankAccount

        log.debug "bankAccount:${bankAccount} ${contract.customer.bankAccount}"
        contract.customer = customer
        customer.bankAccount = bankAccount
        contract.products = products
        contract.calculateAmounts()

        log.debug "bankAccount:${bankAccount} ${contract.customer.bankAccount}"
        
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
        
        log.debug "contract:${contract}\n shiroUser:${shiroUser}\n customer:${customer} \n products:${session.products}"
        [contract:contract,customer:customer,shiroUser:shiroUser,products:products]
    }

    // check payment method (add products to contract)
    def step2 = {

        log.debug " step 2 called ${params.email}"
        
        def contract = session.contract
        contract.products = session.products
        def bankAccount = session.bankAccount
        def customer = session.customer
        def shiroUser = session.shiroUser

        if(params.email || params.email == ''){          
            contract.properties = params
            customer.properties = params
            shiroUser.properties = params

            shiroUser.username = params.email
            //shiroUser.passwordHash = new Sha512Hash(params.email).toHex()
            shiroUser.passwordHash = params.email
            contract.products = session.products
            customer.bankAccount = bankAccount
            
            contract.customer = customer
            customer.addToShiroUsers(shiroUser)
        }
        
        contract.calculateAmounts()
        session.customer = customer
        session.shiroUser = shiroUser
        session.contract = contract
        session.products = contract.products

        log.debug "${contract}\n ${shiroUser}\n ${customer} ${contract.paymentMethod}"

        if(!contract.validate()){
            log.debug "contract has errors!"
            contract.errors.allErrors.each {
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
        
        log.debug "contract:${contract}\n shiroUser:${shiroUser}\n customer:${customer} \n products:${session.products}"

        if(contract.paymentMethod == 0)
        [render(view: "step3", model: [contract:contract,customer:customer,shiroUser:shiroUser])]
            
       
        [contract:contract,customer:customer,shiroUser:shiroUser]
    }

    //display contract data
    def step3 = {
        log.debug "step 3 called ${params}"

        def contract = session.contract
        contract.calculateAmounts()
        def customer = session.customer
        def shiroUser = session.shiroUser
        def bankAccount = session.bankAccount

        if(params.accountOwner || params.email){
            log.debug "here we go. ... ${params.accountOwner} ${params.email}"
            if(params.accountOwner){
                bankAccount = new BankAccount()
                log.debug "adding bankAccount ${params.accountOwner}"
                bankAccount.properties = params
                session.bankAccount = bankAccount
            }       
            else{
                contract = new Contract()
                customer = new Customer()
                shiroUser = new ShiroUser()
                contract.properties = params
                customer.properties = params
                shiroUser.properties = params
                contract.products = session.products
                shiroUser.username = params.email
                /**
                params.product.each{
                if(it!=null && it!='null')
                log.debug "adding product ${Product.get(it)}"
                contract.addToProducts(Product.get(it))
                }*/
            }
        }
        
        customer.bankAccount = bankAccount
        contract.customer = customer
        contract.calculateAmounts()
        session.contract = contract
        session.customer = customer
        session.shiroUser = shiroUser
        session.products = contract.products

        customer.addToShiroUsers(shiroUser)
       
        log.debug "contract:${contract} \n shiroUser:${shiroUser}\n customer:${customer} \n products:${session.products}"

        [contract:contract,customer:customer,shiroUser:shiroUser,bankAccount:bankAccount]
    }

    def register = {
        log.debug "register called"

        def contract = session.contract
        def bankAccount = session.bankAccount
        def shiroUser = session.shiroUser

        def customer = session.customer
        def products = session.products
        contract.customer = customer

        log.debug "contract:${contract}\n shiroUser:${shiroUser}\n customer:${customer}"
        
        if(shiroUser.validate() &&
            customer.validate() &&
            bankAccount.validate() &&
            contract.validate() &&
            contractService.addContract(contract,customer,shiroUser,bankAccount,products))
            {
            session.contract = contract
            params.put("printLetterHead",true)
            params.put("imageUrl","${HelperTools.getServerAndContext(request)}/img/logo_LeSpace.gif")

            def reportDef = new JasperReportDef(name:'contract',
                fileFormat:JasperExportFormat.PDF_FORMAT,
                reportData:[contract],
                parameters:params
            )

            log.debug "trying to send email to: ${customer.email}"
            mailService.sendMail {
                multipart true
                to customer.email
                from grailsApplication.config.grails.mail.from?grailsApplication.config.grails.mail.from:"noemail@le-space.de"
                //cc "marge@g2one.com", "ed@g2one.com"
                //bcc "joe@g2one.com"
                subject "Le Space Registrierung"             //message(code: "contract.formErrors",args: [ "" ])
                body "${contract?.customer?.firstname} ${contract?.customer?.lastname},\n im Anhang erhalten ihren Le Space Vertrag. Herzlich Willkommen!"
                attachBytes "contract_${contract?.id}_${contract?.customer?.company?.replace(' ','_')}.pdf", "application/pdf", jasperService.generateReport(reportDef).toByteArray()  //contentOrder.getBytes("UTF-8")
            }
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
        def customer = new Customer()
        def shiroUser = new ShiroUser()

        contract.properties=params
        customer.properties = params
        shiroUser.properties = params
        shiroUser.username = params.email
        contract.customer = customer
        customer.addToShiroUsers(shiroUser)
        log.debug "quantity: ${contract.quantity} ${params} ${contract.customer.reverseChargeSystem} "
        log.debug params.id
        def p
        if(params.id && params.id!='0'){
            p = Product.get(params.id)
            log.debug "adding product to contract... ${p} ${params.id}"
            contract.addToProducts(p)
            contract.calculateAmounts()
       
            session.contract=contract
            log.debug "load options of product ${p}  params.id:${params.id}"
            session.options = []

            //if(params.id)
            def options = le.space.Product.findAll('from Product as p where p.option = ?', [p])

            session.options = options
            session.products = contract.products


            log.debug "found options ${options} ${session.contract} params.id:${params.id}"
        }
        [contract:session.contract,options:session.options,product:p]
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
        session.products = contract.products
        session.contract = contract

        [render(view: "_sum", model: [contract:contract])]
    }

    def contractPdf = {
        
        if(params.id)
        session.contract = Contract.get(params.id)

        def contract = session.contract

        log.debug contract.customer
        log.debug contract.customer.bankAccount
        contract.products.each{
            log.debug it
        }
        def reportDef = new JasperReportDef(name:'contract',
            fileFormat:JasperExportFormat.PDF_FORMAT,
            reportData:[contract],
            parameters:params
        )

        /**
         * JasperReportDef has the following properties:
         * name - Name of the Report. (Required)
         * fileFormat - Fileformat of the Report. Please use the JasperExportFormat Enum. (Required)
         * folder - The folder where you placed your reports. Defaults to /reports if unset and no global setting (jasper.report.dir in Config.groovy) exists.
         * reportData - Collection containing the data of your report (leave empty if you want to use a SQL query inside your report)
         * locale - Locale to use in the report generation.
         * parameters - All additional parameters as a Map.
         
        <g:hiddenField name="id" value="${contract?.id}" />
        <g:hiddenField name="_format" value="PDF" />
        <g:hiddenField name="_inline" value="false" />
        <g:hiddenField name="_name" value="contract_${contract?.id}_${contract?.customer?.company?.replace(' ','_')}" />
        <g:hiddenField name="_file" value="contract"  />
         */
        /*
        def reportDef = new JasperReportDef(name:'contract',
        fileFormat:JasperExportFormat.PDF_FORMAT,
        reportData:[contract],
        parameters:params
        )

        KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
        ks.load(new FileInputStream("/tmp/keystore.ks"), "hurra2011!".toCharArray());
        String alias = (String)ks.aliases().nextElement();
        java.security.PrivateKey key = (java.security.PrivateKey)ks.getKey(alias, "hurra2011!".toCharArray());
        Certificate[] chain = ks.getCertificateChain(alias);
        PdfReader reader = new PdfReader(jasperService.generateReport(reportDef).toByteArray());
        ByteArrayOutputStream fout = new ByteArrayOutputStream();
        //FileOutputStream fout = new FileOutputStream("/tmp/signed.pdf");
        char c = '\0'

        PdfStamper stp = PdfStamper.createSignature(reader, fout, c);
        PdfSignatureAppearance sap = stp.getSignatureAppearance();
        sap.setCrypto(key, chain, null, PdfSignatureAppearance.SELF_SIGNED);
        sap.setReason("I'm the author");
        sap.setLocation("Leipzig");
        // comment next line to have an invisible signature
        sap.setVisibleSignature(new Rectangle(100, 100, 200, 200), 1, null);
        stp.close();*/






        //  org.apache.commons.io.FileUtils.writeByteArrayToFile(new File("/tmp/contract_${contract?.id}_${contract?.customer?.company?.replace(' ','_')}.pdf"),jasperService.generateReport(reportDef).toByteArray())
        
        response.setHeader("Content-disposition", "attachment; filename="+(reportDef.parameters._name ?: reportDef.name) + "." + reportDef.fileFormat.extension);
        response.contentType = reportDef.fileFormat.mimeTyp
        response.characterEncoding = "UTF-8"
        //response.outputStream << fout.toByteArray() //reportDef.contentStream.toByteArray()
        response.outputStream << jasperService.generateReport(reportDef).toByteArray()
        
        //log.info "contractPdf called. with ${contract} \nand products: ${contract.products} \nand customer: ${contract.customer} \nand bankAccount:${contract.customer.bankAccount} \n and users: ${contract.customer.shiroUsers}"
        //chain(controller:"jasper", action:"index", model:[data:[contract]],params:params)
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