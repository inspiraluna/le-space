package le.space



class ContractRegistrationTests extends grails.util.WebTest {


    void testAddDayTicket() {
        config easyajax: 'true', easyajaxdelay: '10000';
        invoke '/anmeldung'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Anmeldung"

        setInputField name: "salutation", value: "Herr"
        setInputField name: "firstname", value: "Nico"
        setInputField name: "lastname", value: "Krause"
        setInputField name: "addressLine1", value: "Lichtenberg 44"
        setInputField name: "addressLine2", value: "(oberes Geschoss)"
        setInputField name: "zip", value: "D-84307"
        setInputField name: "city", value: "Eggennfelden"
        setSelectField description: "choosing the country", name: "country.id", value: "38"
        setInputField name: "email", value: "nico2@le-space.de"

        setInputField name: "tel1", value: "08721 12132"
        setInputField name: "telMobile", value: "0174 9891949"
        //setInputField name: "company", value: "Softwareberatung Nico Krause"
        setInputField name: "occupation", value: "Softwareentwickler, Yogalehrer, & Coworking Space Betreiber"
        setInputField name: "url", value: "http://www.le-space.de"
        setCheckbox   name: "allowPublishNameOnWebsite", checked:true
        forceHiddenInputField name: "contractStart_year", value:"2010"
        forceHiddenInputField name: "contractStart_month", value:"09"
        forceHiddenInputField name: "contractStart_day", value:"1"
        forceHiddenInputField name: "contractStart_hour",  value:"0"
        forceHiddenInputField name: "contractStart_minute", value:"0"

        setSelectField description: "choosing the day ticket", name: "product", value: "1"

        //verifyText "contract.product.1"

        setRadioButton description: "choosing payment method", name: "paymentMethod", value: "1"


        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 8.40"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 1.60"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 10.00"

        clickButton "contract.forward"

        
        setInputField name: "accountNo", value: "110280"
        setInputField name: "bankNo", value: "74391400"
        setInputField name: "bankName", value: "Rottaler Volksbank Eggenfelden"
        setInputField name: "accountOwner", value: "Nico Krause"
        setCheckbox   name: "directDebitPermission", checked:true
        clickButton "contract.forward"
        clickButton "contract.back"
        verifyInputField name: "accountNo", value: "110280"
        verifyInputField name: "bankNo", value: "74391400"
        verifyInputField name: "bankName", value: "Rottaler Volksbank Eggenfelden"
        verifyInputField name: "accountOwner", value: "Nico Krause"
        verifyCheckbox   name: "directDebitPermission", checked:true
        clickButton "contract.forward"


        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 8.40"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 1.60"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 10.00"

        clickButton "contract.back"
        verifyInputField name: "accountNo", value: "110280"
        verifyInputField name: "bankNo", value: "74391400"
        verifyInputField name: "bankName", value: "Rottaler Volksbank Eggenfelden"
        verifyInputField name: "accountOwner", value: "Nico Krause"
        verifyCheckbox   name: "directDebitPermission", checked:true
        clickButton "contract.back"
        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 8.40"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 1.60"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 10.00"

        clickButton "contract.forward"
        clickButton "contract.forward"
        
        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 8.40"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 1.60"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 10.00"

        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true
        clickButton "contract.register"
        
        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true
        clickButton "contract.register"

        clickButton "contract.print"

        pdfVerifyText description:"amountNet", text:"8.4", regex: "true"
        pdfVerifyText description:"amountVat", text:"1.6", regex: "true"
        pdfVerifyText description:"amountVat", text:"10.00", regex: "true"
        pdfVerifyText description:"salutation", text: "Herr", regex: "true"
        pdfVerifyText description:"firstname", text: "Nico", regex: "true"
        pdfVerifyText description:"lastname", text: "Krause", regex: "true"
        pdfVerifyText description:"addressLine1", text: "Lichtenberg 44", regex: "true"
        pdfVerifyText description:"addressLine2", text: "(oberes Geschoss)", regex: "true"
        pdfVerifyText description:"zip", text: "D-84307", regex: "true"
        pdfVerifyText description:"city", text: "Eggenfelden", regex: "true"
        pdfVerifyText description:"country", text: "Deutschland", regex: "true"
        pdfVerifyText description:"accountNo", text: "110280", regex: "true"
        pdfVerifyText description:"bankNo", text: "74391400", regex: "true"
        pdfVerifyText description:"bankName", text: "Rottaler Volksbank Eggenfelden", regex: "true"
        pdfVerifyText description:"accountOwner", text: "Nico Krause", regex: "true"
    }

    
    void testAddDayTicketFailure() {
        config easyajax: 'true', easyajaxdelay: '10000';
        invoke '/anmeldung'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Anmeldung"

        setInputField name: "salutation", value: "Herr"
        setInputField name: "firstname", value: "Nico3"
        setInputField name: "lastname", value: "Krause"
       // setInputField name: "addressLine1", value: "Lichtenberg 44"
        //setInputField name: "addressLine2", value: "(oberes Geschoss)"
        setInputField name: "zip", value: "D-84307"
        setInputField name: "city", value: "Eggennfelden"
        setSelectField description: "choosing the country", name: "country.id", value: "38"
        setInputField name: "email", value: "nico3@le-space.de"

        setInputField name: "tel1", value: "08721 12132"
        setInputField name: "telMobile", value: "0174 9891949"
        //setInputField name: "company", value: "Softwareberatung Nico Krause"
        setInputField name: "occupation", value: "Softwareentwickler, Yogalehrer, & Coworking Space Betreiber"
        setInputField name: "url", value: "http://www.le-space.de"
        setCheckbox   name: "allowPublishNameOnWebsite", checked:true
        forceHiddenInputField name: "contractStart_year", value:"2010"
        forceHiddenInputField name: "contractStart_month", value:"09"
        forceHiddenInputField name: "contractStart_day", value:"1"
        forceHiddenInputField name: "contractStart_hour",  value:"0"
        forceHiddenInputField name: "contractStart_minute", value:"0"

        setSelectField description: "choosing the day ticket", name: "product", value: "1"

     

        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 8.40"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 1.60"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 10.00"

        clickButton "contract.forward"

       /** forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true
        clickButton "contract.register"
        
        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true
        clickButton "contract.register"

        clickButton "contract.print"

        pdfVerifyText description:"amountNet", text:"8.4", regex: "true"
        pdfVerifyText description:"amountVat", text:"1.6", regex: "true"
        pdfVerifyText description:"amountVat", text:"10.00", regex: "true"
        pdfVerifyText description:"salutation", text: "Herr", regex: "true"
        pdfVerifyText description:"firstname", text: "Nico", regex: "true"
        pdfVerifyText description:"lastname", text: "Krause", regex: "true"
        pdfVerifyText description:"addressLine1", text: "Lichtenberg 44", regex: "true"
        pdfVerifyText description:"addressLine2", text: "(oberes Geschoss)", regex: "true"
        pdfVerifyText description:"zip", text: "D-84307", regex: "true"
        pdfVerifyText description:"city", text: "Eggenfelden", regex: "true"
        pdfVerifyText description:"country", text: "Deutschland", regex: "true"
        pdfVerifyText description:"accountNo", text: "110280", regex: "true"
        pdfVerifyText description:"bankNo", text: "74391400", regex: "true"
        pdfVerifyText description:"bankName", text: "Rottaler Volksbank Eggenfelden", regex: "true"
        pdfVerifyText description:"accountOwner", text: "Nico Krause", regex: "true"*/
    }

    void testAddReverseChargeSystemContract() {

        config easyajax: 'true', easyajaxdelay: '10000'

        invoke '/anmeldung'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Anmeldung"

        setInputField name: "salutation", value: "Herr"
        setInputField name: "firstname", value: "Eric"
        setInputField name: "lastname", value: "Poscher"
        setInputField name: "addressLine1", value: "Riedbrunnenstr. 4"
        setInputField name: "addressLine2", value: "-"
        setInputField name: "zip", value: "6850"
        setInputField name: "city", value: "Dornbirn"
        setSelectField description: "choosing the country", name: "country.id", value: "133"
        setInputField name: "email", value:"eric.poscher@epe.at"


        setCheckbox   name: "allowPublishNameOnWebsite", checked:true
        forceHiddenInputField name: "contractStart_year", value:"2010"
        forceHiddenInputField name: "contractStart_month", value:"09"
        forceHiddenInputField name: "contractStart_day", value:"1"
        forceHiddenInputField name: "contractStart_hour",  value:"0"
        forceHiddenInputField name: "contractStart_minute", value:"0"

        setCheckbox   name: "reverseChargeSystem", checked:true
        setInputField name: "reverseChargeSystemID", value: "eRICsATUNo"
        
        setSelectField description: "choosing the day ticket", name: "product", optionIndex: "4"

        verifyText "anmelden"

        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 100.00"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 0.00"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 100.00"

        clickButton "contract.forward"
       
        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true
        
        clickButton "contract.register"
        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true

        clickButton "contract.register"
        clickButton "contract.print"

        pdfVerifyText description:"UstId", text:"eRICsATUNo", regex: "true"
        pdfVerifyText description:"Reverse Charge System Remark", text:"(Reverse Charge System)", regex: "true"
        pdfVerifyText description:"amountVat", text:"100.00", regex: "true"
    }

    void testAdd10DayTicket() {

        config easyajax: 'true', easyajaxdelay: '10000'

        invoke '/anmeldung'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Anmeldung"

        setInputField name: "salutation", value: "Herr"
        setInputField name: "firstname", value: "Martin"
        setInputField name: "lastname", value: "Hilbrecht"
        setInputField name: "addressLine1", value: "-"
        setInputField name: "addressLine2", value: "-"
        setInputField name: "zip", value: "D-xxxxx"
        setInputField name: "city", value: "Lauf"
        setSelectField description: "choosing the country", name: "country.id", value: "38"
        setInputField name: "email", value: "martin-hilbrecht2@le-space.de"

        //Birthday !

        //  setInputField name: "tel1", value: "08721 12132"
        //  setInputField name: "telMobile", value: "0174 9891949"
        //  setInputField name: "company", value: "Softwareberatung Nico Krause"
        //  setInputField name: "occupation", value: "Softwareentwickler, Yogalehrer, & Coworking Space Betreiber"
        //   setInputField name: "url", value: "http://www.le-space.de"
        setCheckbox   name: "allowPublishNameOnWebsite", checked:true
        forceHiddenInputField name: "contractStart_year", value:"2010"
        forceHiddenInputField name: "contractStart_month", value:"09"
        forceHiddenInputField name: "contractStart_day", value:"1"
        forceHiddenInputField name: "contractStart_hour",  value:"0"
        forceHiddenInputField name: "contractStart_minute", value:"0"

        setSelectField description: "choosing the 10 day ticket", name: "product", optionIndex: "6"

        verifyText "anmelden"

        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 75.63"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 14.37"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 90.00"


        clickButton "contract.forward"
        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 75.63"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 14.37"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 90.00"

        clickButton "contract.back"
        clickButton "contract.forward"

        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 75.63"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 14.37"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 90.00"

        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true        
        clickButton "contract.register"

        forceInputFieldAttribute name:"register", attributeName:"disabled", attributeValue:""
        setCheckbox   name: "agbs", checked:true
        clickButton "contract.register"
        
        clickButton "contract.print"

        pdfVerifyText description:"amountNet", text:"75.63", regex: "true"
        pdfVerifyText description:"amountVat", text:"14.37", regex: "true"
        pdfVerifyText description:"amountVat", text:"90.00", regex: "true"
    }

    void testCustomerPublicationOnWebsite() {

        config easyajax: 'true', easyajaxdelay: '10000';
        invoke '/user'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Nutzer"
        verifyText "Martin"
        verifyText "Hilbrecht"
        verifyText "Nico"
        verifyText "Krause"
    }
}