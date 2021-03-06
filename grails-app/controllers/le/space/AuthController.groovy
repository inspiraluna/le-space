package le.space

import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils

class AuthController {
    def shiroSecurityManager

    def index = { 
        redirect(action: "login", controller:"home",params: params) }

    def login = {
        flash.message = flash.message
        redirect(action: "login", controller:"home",params: params)
        //render(view: "login", controller:"home", model: [ username: params.username, rememberMe: (params.rememberMe != null), targetUri: params.targetUri ])
    }

    def signIn = {

        def authToken = new UsernamePasswordToken(params.username, params.password)
        log.debug "username: ${params.username} password: ${params.password}"
        // Support for "remember me"
        if (params.rememberMe) {
            authToken.rememberMe = true
        }
        
        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.

        def targetUri = params.targetUri ?: "/"

        // Handle requests saved by Shiro filters.
        def savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }
        
        try{
            // Perform the actual login. An AuthenticationException
            // will be thrown if the username is unrecognised or the
            // password is incorrect.
            SecurityUtils.subject.login(authToken)

            if(session.loginParams.ssid){
                
                //http://192.168.182.1:3990/json/logon?username=XXXX&chapchallenge=YYYY&chappassword=0123456789abcdef&lang=EN
                def uamUrl = "http://${session.loginParams.uamip}:${session.loginParams.uamport}/json/logon?username=${params.username}&chapchallenge=${session.loginParams.challenge}&chappassword=${params.password}"
                log.debug "Redirecting to uam url: '${uamUrl}'."
                redirect(url:uamUrl)
            }
            else{
                log.info "Redirecting to '${targetUri}'."
                redirect(uri: targetUri)
            }
        }
        catch (AuthenticationException ex){
            // Authentication failed, so display the appropriate message
            // on the login page.
            log.info "Authentication failure for user '${params.username}'."
            flash.message = message(code: "login.failed")

            // Keep the username and "remember me" setting so that the
            // user doesn't have to enter them again.
            def m = [ username: params.username ]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI too.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }

            // Now redirect back to the login page.
            //chain(view:"login", controller:"home", model:m)
            redirect(action: "login", params: m)
        }
        // redirect(view:"login", controller:"home")
    }

    def signOut = {
        // Log the user out of the application.
        SecurityUtils.subject?.logout()

        // For now, redirect back to the home page.
        redirect(uri: "/")
    }

    def unauthorized = {
        render "You do not have permission to access this page."
    }
}
