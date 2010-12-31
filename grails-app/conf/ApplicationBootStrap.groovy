import org.apache.shiro.crypto.hash.Sha512Hash
import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import le.space.*
import org.tinyradius.util.RadiusServer

class ApplicationBootStrap {

    def RadiusServer server = null;
    
    def init = { servletContext ->

        def adminUser
        
        if(ShiroUser.count()==0){
            log.info"adding demo data application in development mode"
        
            def adminRole = new ShiroRole(name: "Administrator").save()
            log.info("added Administrator role to db")

            def userRole = new ShiroRole(name: "User").save()
            log.info("added User role to db")

            adminUser = new ShiroUser(username: "admin@le-space.de",
                passwordHash: new Sha512Hash("admin").toHex(),
                firstname: "Administrator",
                lastname:"admin",
                email:"admin@le-space.de").save()

            adminUser.addToPermissions("*:*")
            adminUser.addToRoles(adminRole)
            adminUser.save()
        }
            
        if(le.space.Country.count()==0){
            def path = servletContext.getRealPath("./")+"/WEB-INF"
            addAllCountries(path)
            log.debug "Countries in database: ${le.space.Country.count()}"
        }

        //  if(grails.util.GrailsUtil.environment == "development" || grails.util.GrailsUtil.environment == "test") {
        if(le.space.Product.count()==0){
            //Product
            def p1 = new le.space.Product(productNo:"0001",name:"_day_ticket",description:"_day_ticket",priceNet:8.40,vat:19.0,option:null,autoExtendPossible:false,publicProduct:true).save() //10
            def p2 = new le.space.Product(durationType:le.space.Product.DUR_MONTH, productNo:"0002",name:"_12day_in_1_month",description:"_12day_ticket",priceNet:57.98,vat:19.0,option:null,autoExtendPossible:true,publicProduct:true).save() //69
            def p3 = new le.space.Product(duration:7, productNo:"0003",name:"_week_ticket",description:"_week_ticket",priceNet:32.77,vat:19.0,option:null,autoExtendPossible:false,publicProduct:true).save() //39
            def p4 = new le.space.Product(durationType:le.space.Product.DUR_MONTH, productNo:"0004",name:"_month_ticket",description:"_month_ticket",priceNet:100,vat:19.0,option:null,autoExtendPossible:true,publicProduct:true).save() //119
            def p5 = new le.space.Product(durationType:le.space.Product.DUR_MONTH, productNo:"0005",name:"_month_ticket_fix",description:"_month_ticket_fix",priceNet:142.017,vat:19.0,option:null,autoExtendPossible:true,publicProduct:true).save() //169
						
            //Product Options
            def p7 = new le.space.Product(productNo:"0007",name:"_key_week",description:"_key_week",priceNet:14.29,vat:19.0,option:p3,publicProduct:true).save() //17
            def p8 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0008",name:"_key_month",description:"_key_month",priceNet:24.37,vat:19.0,option:p4,publicProduct:true).save() //29
            def p9 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0009",name:"_key_12day_ticket",description:"_key_12day_ticket",priceNet:24.37,vat:19.0,option:p2,allowedLoginDays:12,publicProduct:true).save() //29
			
            def p10 = new le.space.Product(productNo:"0010",name:"_lockbox_day",description:"_lockbox_day",priceNet:2.52,vat:19.0,option:p1,publicProduct:true).save() //3
            def p11 = new le.space.Product(productNo:"0011",name:"_lockbox_week",description:"_lockbox_week",priceNet:10.08,vat:19.0,option:p3,publicProduct:true).save() //12
            def p12 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0012",name:"_lockbox_12_day_ticket",description:"_lockbox_12_day_ticket",priceNet:12.61,vat:19.0,option:p2,publicProduct:true).save() //15
			
            def p13 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0013",name:"_mailbox_12_day_ticket",description:"_mailbox_12_day_ticket",priceNet:24.37,vat:19.0,option:p2,publicProduct:true).save() //29
            def p14 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0014",name:"_mailbox_month_ticket",description:"_mailbox_month",priceNet:24.37,vat:19.0,option:p4,publicProduct:true).save() //29
            def p15 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0015",name:"_mailbox_month_ticket_fix",description:"_mailbox_month",priceNet:24.37,vat:19.0,option:p5,publicProduct:true).save() //29
		
            def p16 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0016",name:"_10day_in_3_months",description:"_10day_in_3_months",priceNet:75.63025210084,vat:19.0,option:null,autoExtendPossible:true,allowedLoginDays:10,duration:3,publicProduct:true).save() //90
            def p17 = new le.space.Product(duration:3, durationType:le.space.Product.DUR_MONTH,productNo:"0017",name:"_lockbox_10day_in_3_months",description:"_lockbox_10day_in_3_months",priceNet:24.37,vat:19.0,option:p16,publicProduct:true).save() //29
			
            def p18 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0018",name:"_key_month",description:"_key_month",priceNet:24.37,vat:19.0,option:p8,publicProduct:true).save() //29

            def p19 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0019",name:"_coworking_visa",description:"_coworking_visa",priceNet:0,vat:19.0,option:null,publicProduct:true).save() //29
            def p20 = new le.space.Product(durationType:le.space.Product.DUR_MONTH,productNo:"0020",name:"_jelly",description:"_jelly",priceNet:0,vat:19.0,option:null,publicProduct:true).save() //29
            

            log.debug "Products in database: ${le.space.Product.count()}"
        }

        
        if(le.space.Link.count()==0){
            new le.space.Link(name:"Wikipedia Artikel",url:"http://de.wikipedia.org/wiki/Coworking", pageId:"Coworking Links")
            new le.space.Link(name:"Betahaus Berlin",url:"http://www.betahaus.de/", pageId:"Coworking in Deutschland")
            new le.space.Link(name:"Coworking international",url:"http://coworking.pbworks.com/", pageId:"Coworking International")    
        }

        if(le.space.Photo.count()==0){
            //new le.space.Photo(filename:"",directory:"",title:"",pageId:"").save()
            new le.space.Photo(filename:"workshop_teilnehmer1",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()
            new le.space.Photo(filename:"workshop_teilnehmer2",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()
            new le.space.Photo(filename:"workshop_teilnehmer3",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()
            new le.space.Photo(filename:"workshop_teilnehmer4",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()
            new le.space.Photo(filename:"workshop_teilnehmer5",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()
            new le.space.Photo(filename:"workshop_teilnehmer6",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()
            new le.space.Photo(filename:"workshop_teilnehmer7",directory:"/img/burg_workshop_people/",title:"Workshop Burg Giebichenstein",pageId:"impressum").save()

            new le.space.Photo(filename:"beamer2",directory:"/img/coworking/",title:"Beamer",pageId:"preise").save()
            new le.space.Photo(filename:"brainstorming",directory:"/img/coworking/",title:"Brainstorming",pageId:"preise").save()
            new le.space.Photo(filename:"fun",directory:"/img/coworking/",title:"Fun",pageId:"preise").save()
            new le.space.Photo(filename:"gespraechsrunde",directory:"/img/coworking/",title:"Gesprächsrunde",pageId:"preise").save()
            new le.space.Photo(filename:"rundertisch",directory:"/img/coworking/",title:"Rundertisch",pageId:"preise").save()
            new le.space.Photo(filename:"workshop",directory:"/img/coworking/",title:"Workshop",pageId:"preise").save()
            new le.space.Photo(filename:"zusammen_arbeiten",directory:"/img/coworking/",title:"Zusammenarbeiten",pageId:"preise").save()

            new le.space.Photo(filename:"arbeiten01",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()
            new le.space.Photo(filename:"arbeiten02",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()
            new le.space.Photo(filename:"arbeiten03",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()
            new le.space.Photo(filename:"ruhe",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()
            new le.space.Photo(filename:"raum",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()
            new le.space.Photo(filename:"hausk",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()
            new le.space.Photo(filename:"tapetenwerk",directory:"/img/erstes_treffen/",title:"foto:reneschaeffer.de",pageId:"startseite").save()

            new le.space.Photo(filename:"arbeitsplatz",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
            new le.space.Photo(filename:"buero",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
            new le.space.Photo(filename:"desktop",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
            new le.space.Photo(filename:"kreatives_chaos",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
            new le.space.Photo(filename:"laptop",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
            new le.space.Photo(filename:"resonanzen_festival",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
            new le.space.Photo(filename:"user",directory:"/img/desktops/",title:"foto:reneschaeffer.de",pageId:"raeume").save()
 
            new le.space.Photo(filename:"beamer1",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()
            new le.space.Photo(filename:"flipchart2",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()
            new le.space.Photo(filename:"praesentation",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()
            new le.space.Photo(filename:"praesentation2",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()
            new le.space.Photo(filename:"praesentation3",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()
            new le.space.Photo(filename:"praesentation6",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()
            new le.space.Photo(filename:"praesentation7",directory:"/img/praesentation/",title:"foto:burg giebichenstein - halle a.d.saale",pageId:"user").save()

            new le.space.Photo(filename:"breakout",directory:"/img/space_impressionen/",title:"Breakout",pageId:"coworking").save()
            new le.space.Photo(filename:"coworking_leipzig",directory:"/img/space_impressionen/",title:"Coworking Leipzig",pageId:"coworking").save()
            new le.space.Photo(filename:"flipchart",directory:"/img/space_impressionen/",title:"Flipchart",pageId:"coworking").save()
            new le.space.Photo(filename:"haengematte",directory:"/img/space_impressionen/",title:"Hängematte",pageId:"coworking").save()
            new le.space.Photo(filename:"le_space",directory:"/img/space_impressionen/",title:"Le Space - Bürogemeinschaft 2.0",pageId:"coworking").save()
            new le.space.Photo(filename:"sofa",directory:"/img/space_impressionen/",title:"Sofa - Bürogemeinschaft 2.0",pageId:"coworking").save()
            new le.space.Photo(filename:"waescheleine",directory:"/img/space_impressionen/",title:"Wäscheleine - Bürogemeinschaft 2.0",pageId:"coworking").save()

            new le.space.Photo(filename:"DJ_Leipzig",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            new le.space.Photo(filename:"talk",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            new le.space.Photo(filename:"ausstellung",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            new le.space.Photo(filename:"coworking_jungs",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            new le.space.Photo(filename:"maedchen_space",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            new le.space.Photo(filename:"menschen",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            new le.space.Photo(filename:"partyspace",directory:"/img/space_party",title:"foto:reneschaeffer.de",pageId:"faq,kontakt").save()
            log.debug "Photos in database: ${le.space.Photo.count()}"
        }

        if(le.space.Customer.count()==0){

            def userNico = new ShiroUser(username:"nico",passwordHash:new Sha512Hash("nico").toHex(),salutation:"Herr",firstname:"Nico",lastname:"Krause",
                email:"nico@le-space.de",birthday:new Date(),telMobile:"+49 174 9891949",occupation:"Softwareentwickler, Coworking Space Founder, Yoga Teacher",
                twitterName:"inspiraluna",facebookName:"inspiraluna").save()
            userNico.addToPermissions("*:*")
            userNico.addToRoles(ShiroRole.findByName("User"))
            userNico.save()

            def customerNico = new Customer(company:"Softwareberatung Nico Krause",addressLine1:"Lichtenberg 44",addressLine2:"(oberes Geschoss)",zip:"D-84307",city:"Eggenfelden",country:Country.findByName("Deutschland"),
                tel1:"+49 8721 12132",fax:"+49 8721 12132",url:"www.twitter.com/inspiraluna",
                allowPublishNameOnWebsite:true).save()

            def bankAccount = new BankAccount(directDebitPermission:false,
                accountOwner:"Nico Krause",accountNo:"119380",bankNo:"94391400",bankName:"Inntaler Volksbank",IBANNo:"12312311",BICNo:"123123123").save()
            
            customerNico.bankAccount = bankAccount
            customerNico.addToShiroUsers(userNico)
            customerNico.save()

            def userJulian = new ShiroUser(username:"julian",passwordHash:new Sha512Hash("julian").toHex(),salutation:"Herr",firstname:"Julian",lastname:"Moritz",
                email:"julian@le-space.de",birthday:new Date(),telMobile:"",occupation:"Softwareentwickler",
                twitterName:"",facebookName:"").save()

            userJulian.addToPermissions("*:*")
            userJulian.addToRoles(ShiroRole.findByName("User"))
            userJulian.save()

            def customerJulian = new Customer(company:"Julian Moritz",addressLine1:"Nonnenstraße 28",addressLine2:"",zip:"D-84307",city:"Leipzig",country:Country.findByName("Deutschland"),
                tel1:"+49 341 4955898",fax:"+49 341 4955898",url:"www.julianmoritz.de",
                allowPublishNameOnWebsite:true).save()

            def bankAccountJulian = new BankAccount(directDebitPermission:false,
                accountOwner:"Julian Moritz",accountNo:"1802247080",bankNo:"94391422",bankName:"Sparkasse Leipzig",IBANNo:"86055592",BICNo:"123123123").save()
            
            customerJulian.bankAccount = bankAccountJulian
            customerJulian.addToShiroUsers(userJulian)
            customerJulian.save()


            log.debug "ShiroUsers in database: ${le.space.ShiroUser.count()}"
            log.debug "Customers in database: ${le.space.Customer.count()}"

        }
        if(le.space.Contract.count()==0){

            def contract1 = new Contract(customer:Customer.get(1),
                conditions:"",
                quantity:1,
                paymentMethod:Contract.PM_CASH,
                contractStart:new Date()-300,
                autoExtend:false,createdBy:adminUser,modifiedBy:adminUser)

            log.debug " ${le.space.Product.get(5)} ${le.space.Customer.get(1)}"

            contract1.addToProducts(le.space.Product.get(5))
            contract1.save()

            def contract2 = new Contract(customer:Customer.get(2),
                conditions:"",
                quantity:1,
                paymentMethod:Contract.PM_DIRECT_DEBIT,
                contractStart:new Date(),
                autoExtend:true,createdBy:adminUser,modifiedBy:adminUser)

            log.debug " ${le.space.Product.get(1)} ${le.space.Customer.get(1)}"

            contract2.addToProducts(le.space.Product.get(1))
            contract2.save()

            log.debug "Contracts in database: ${le.space.Contract.count()}"

        }
        server = new LeSpaceRadiusServer()
        server.start(true, true)

        log.debug "le space radius server started"

       


        
    }

    def destroy = {
        server.stop();
    }

    def addAllCountries(String path){

        def f1 = new File(path+"/data/liste_countries.html")

        def lineCounter = 0
        boolean startReading

        //quick & dirthy parsen des html dokuments.
        f1.eachLine{

            lineCounter++

            if(startReading && it.contains("<tr>"))
            lineCounter=0

            if(startReading && lineCounter == 1){
                def startPos = it.indexOf("title")+7
                def endPos = it.indexOf("\"",startPos)
                String countryName = it.substring(startPos,endPos)
                log.debug(countryName)
                new Country(name:countryName).save()
            }

            if(!startReading && it.contains("title=\"Europäische Union\">Europäische Union</a></i>"))
            startReading = true

            if(startReading && it.contains("<p><a name=\"Besonderheiten\" id=\"Besonderheiten\"></a></p>"))
            startReading = false
        }
        
        log.debug "${lineCounter}"
    }
}