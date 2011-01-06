<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="admin" />
    <title>Radius Client Test</title>
  </head>
  <body>
    <h1>Radius Client</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:form>
    Radius Server IP: <input type="text" id="radiusServerIP" name="radiusServerIP" value="${radiusServerIP}"/><br/>
    Radius Server Shared Secret: <input type="text" id="radiusServerSharedSecret" name="radiusServerSharedSecret" value="${radiusServerSharedSecret}"/><br/>
    Username: <input type="text" id="radiusUsername" name="radiusUsername" value="${radiusUsername}"/><br/>
    Password: <input type="text" id="radiusPassword" name="radiusPassword" value="${radiusPassword}"/><br/>
    <g:actionSubmit class="radius" action="radius" value="Login" />
  </g:form>
</body>
</html>
