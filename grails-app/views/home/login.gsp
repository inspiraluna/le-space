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
          <h1 class="first">Login</h1>
          <p>Um den Coworking Space zu nutzen müßt Ihr Euch hier einloggen:
          Du hast noch kein Passwort? Dann registriere Dich hier:
          <a href="${le.space.HelperTools.makeSSL(createLinkTo(dir:'anmeldung', absolute:true))}">Anmelden</a></p>
          <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
          </g:if>
          <g:form controller="auth" action="signIn">
            <input type="hidden" name="targetUri" value="${targetUri?targetUri:'/contract/profile'}" />
            <table>
              <thead>
                <tr>
                  <td>Username:</td>
                  <td><input type="text" name="username" value="${username}" /></td>
                </tr>
                <tr>
                  <td>Password:</td>
                  <td><input type="password" name="password" value="" /></td>
                </tr>
                <tr>
                  <td>Remember me?:</td>
                  <td><g:checkBox name="rememberMe" value="${rememberMe}" /></td>
              </tr>
              <tr>
                <td />
                <td><input type="submit" value="Sign in" /></td>
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




