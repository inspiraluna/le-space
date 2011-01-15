package le.space


class UserProfileTests extends grails.util.WebTest {

    void suite() {
        testChangePassword()
    }

    void userProfileLogin(String password) {
        config easyajax: 'true', easyajaxdelay: '10000';
        invoke '/login'
        verifyTitle "Le Space (beta) - Coworking in Leipzig"
        //clickLink "Anmeldung"

        setInputField name: "username", value: "nico@le-space.de"
        setInputField name: "firstname", value: password
        clickButton "contract.print"
    }

    void testChangePassword(){
        
        userProfileLogin("nico")

        setInputField name: "passwordOld", value: "nicowrong"
        clickButton "shiroUser.passwordChangeButton.label"
        verifyText "login.failed.wrongPassword"

        setInputField name: "passwordOld", value: "nico"
        setInputField name: "passwordNew", value: "nico1"
        setInputField name: "passwordNewAgain", value: "nico2"


        clickButton "shiroUser.passwordChangeButton.label"
        verifyText "login.failed.passwordDontMatch"

        setInputField name: "passwordOld", value: "nico"
        setInputField name: "passwordNew", value: "niconeu"
        setInputField name: "passwordNewAgain", value: "nicoenu"

        clickButton "shiroUser.passwordChangeButton.label"
        verifyText "login.passwordChanged"
        
        clickLink id: "logout"
        userProfileLogin("niconeu")

        setInputField name: "passwordOld", value: "niconeu"
        setInputField name: "passwordNew", value: "nico"
        setInputField name: "passwordNewAgain", value: "nico"

        clickButton "shiroUser.passwordChangeButton.label"
        verifyText "login.passwordChanged"
    }
}
