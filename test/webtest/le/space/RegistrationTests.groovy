package le.space



class RegistrationTests extends grails.util.WebTest {

    // Unlike unit tests, functional tests are sometimes sequence dependent.
    // Methods starting with 'test' will be run automatically in alphabetical order.
    // If you require a specific sequence, prefix the method name (following 'test') with a sequence
    // e.g. test001XclassNameXListNewDelete

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
        setInputField name: "country", value: "Deutschland"
        setInputField name: "email", value: "nico@le-space.de"

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
        setSelectField description: "choosing the day ticket", name: "product", optionIndex: "1"

        //verifyText "contract.product.1"

        setRadioButton description: "choosing paymenet method", name: "paymentMethod", value: "1"


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
        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 8.40"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 1.60"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 10.00"

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
        pdfVerifyText description:"city", text: "Eggennfelden", regex: "true"
        pdfVerifyText description:"country", text: "Deutschland", regex: "true"
        pdfVerifyText description:"accountNo", text: "110280", regex: "true"
        pdfVerifyText description:"bankNo", text: "74391400", regex: "true"
        pdfVerifyText description:"bankName", text: "Rottaler Volksbank Eggenfelden", regex: "true"
        pdfVerifyText description:"accountOwner", text: "Nico Krause", regex: "true"


    }

       void testAdd10DayTicket() {
        config easyajax: 'true', easyajaxdelay: '10000';
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
        setInputField name: "country", value: "Deutschland"
        setInputField name: "email", value: "martin-hilbrecht@le-space.de"

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
        setSelectField description: "choosing the day ticket", name: "product", optionIndex: "6"

        verifyText "anmelden"

        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 75.63"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 14.37"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 90.00"


        clickButton "contract.forward"
        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 75.63"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 14.37"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 90.00"

        clickButton "contract.back"
        setSelectField description: "choosing the day ticket", name: "product", optionIndex: "6"
        clickButton "contract.forward"

        verifyXPath description:"amountNet ", xpath:"//td[@id='amountNet']", text:"€ 75.63"
        verifyXPath description:"amountVat ", xpath:"//td[@id='amountVat']", text:"€ 14.37"
        verifyXPath description:"amountGross ", xpath:"//td[@id='amountGross']", text:"€ 90.00"


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