package le.space



class ProfileTests extends grails.util.WebTest {

    void testPassword() {
        
        config easyajax: 'true', easyajaxdelay: '10000';
        userProfileLogin("eric.poscher@epe.at","eric.poscher@epe.at")
        clickLink "Change Password"
        setInputField name: "passwordOld", value: "nicowrong"
        clickButton "shiroUser.passwordChangeButton.label"
        //verifyText "login.failed.wrongPassword"
/**
        setInputField name: "passwordOld", value: "eric.poscher@epe.at"
        setInputField name: "passwordNew", value: "nico1"
        setInputField name: "passwordNewAgain", value: "nico2"


        clickButton "shiroUser.passwordChangeButton.label"
       // verifyText "login.failed.passwordDontMatch"

        setInputField name: "passwordOld", value: "eric.poscher@epe.at"
        setInputField name: "passwordNew", value: "niconeu"
        setInputField name: "passwordNewAgain", value: "nicoenu"

        clickButton "shiroUser.passwordChangeButton.label"
        //verifyText "login.passwordChanged"

        clickLink id: "logout"
        userProfileLogin("eric.poscher@epe.at","eric.poscher@epe.at")

        setInputField name: "passwordOld", value: "niconeu"
        setInputField name: "passwordNew", value: "eric.poscher@epe.at"
        setInputField name: "passwordNewAgain", value: "eric.poscher@epe.at"

        clickButton "shiroUser.passwordChangeButton.label"
        //verifyText "login.passwordChanged"
        */
    }

    void testCustomerData() {

        config easyajax: 'true', easyajaxdelay: '10000';
        userProfileLogin("nico2@le-space.de","nico2@le-space.de")
        setInputField name: "company", value: "niconeu"
        setInputField name: "addressLine1", value: "niconeu"
        setInputField name: "addressLine2", value: "niconeu"
        setInputField name: "zip", value: "niconeu"
        setInputField name: "city", value: "niconeu"

        setSelectField description: "choosing the country", name: "country.id", value: "132"
        setInputField name: "tel1", value: "niconeu"
        setInputField name: "fax", value: "niconeu"
        setInputField name: "url", value: "niconeu"
        
        setCheckbox   name: "allowPublishNameOnWebsite", checked:true
        setCheckbox   name: "reverseChargeSystem", checked:true
        setInputField name: "reverseChargeSystemID", value: "USTID1234567"

        clickButton "default.button.update.label"


        setInputField name: "company", value: "company"
        setInputField name: "addressLine1", value: "addressLine1"
        setInputField name: "addressLine2", value: "addressLine2"
        setInputField name: "zip", value: "zip"
        setInputField name: "city", value: "city"

        setSelectField description: "choosing the country", name: "country.id", value: "133"
        setInputField name: "tel1", value: "tel1"
        setInputField name: "fax", value: "fax"
        setInputField name: "url", value: "url"
        
        setCheckbox   name: "allowPublishNameOnWebsite", checked:true
        setCheckbox   name: "reverseChargeSystem", checked:true
        setInputField name: "reverseChargeSystemID", value: "USTID1234567"

    }


    void userProfileLogin(String username, String password) {
        
        config easyajax: 'true', easyajaxdelay: '10000';
        invoke '/login'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Anmeldung"

        setInputField name: "username", value: username
        setInputField name: "password", value: password
        clickButton "contract.login.signIn"
        
    }

}