<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div id="koerper">
      <g:render template="/common/infos" />
      <div id="inhalt">
        <div class="zweispaltig">
          <h1 class="first"><g:message code="login.label" /></h1>
          <p><g:message code="login.intro" />
          <a href="${le.space.HelperTools.makeSSL(createLinkTo(dir:'anmeldung', absolute:true))}"><g:message code="login.register.label" /></a></p>
          <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
          </g:if>
          <g:form controller="auth" action="signIn">
            <input type="hidden" name="targetUri" value="${targetUri?targetUri:'/contract/profile'}" />
            <table border="0">
              <thead>
                <tr>
                  <td><g:message code="contract.login.username" />:</td>
                  <td><input type="text" name="username" value="${username}" /></td>
                </tr>
                <tr>
                  <td><g:message code="contract.login.password" />:</td>
                  <td><input type="password" name="password" value="" /></td>
                </tr>
              <tr>
                <td />
                <td><input type="submit" value="${message(code: 'contract.login.signIn', default: 'Sign In')}" /></td>
              </tr>
              </thead>
            </table>
          </g:form>
        </div>
        <div class="einspaltig">
          <div id="twitterFeed" class="feed"><g:render template="/common/twitterFeed" /></div>
          <g:render template="/common/coworkingFeed" />
          <g:render template="/common/facebookFeed" />
        </div>
        <div class="clear"></div>
      </div></div>
  </body>
</html>




