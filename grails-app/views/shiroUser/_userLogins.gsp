<hr/>
<h2><g:message code="login.label" default="Login" /></h2>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
  <table>
    <tr>
      <th align="left"><g:message code="login.shiroUser.label" default="shiroUser" /></th>
    <th align="left"><g:message code="login.loginStart.label" default="loginStart" /></th>
    <th align="left"><g:message code="login.ipAddress.label"  default="ipAddress" /></th>
    <th align="left"><g:message code="login.macAddress.label" default="macAddress" /></th>
    </tr>
    <g:each in="${loginList}" status="j" var="login">
      <tr>
        <td nowrap>${login?.user?.firstname} ${login?.user?.lastname} (${login?.user?.username}) </td>
        <td nowrap>${login?.loginStart}</td>
        <td nowrap>${login?.ipAddress}</td>
        <td nowrap>${login?.macAddress}</td>
      </tr>
    </g:each>
  </table>
