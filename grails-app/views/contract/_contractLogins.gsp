  <table>
    <tr>
    <th align="left"><g:message code="login.loginStart.label" default="loginStart" /></th>
    <th align="left"><g:message code="login.shiroUser.label" default="shiroUser" /></th>
    </tr>
    <g:each in="${loginList}" status="j" var="login">
      <tr>
      <tr>
        <td nowrap>${login[0]}</td>
        <td nowrap>${login[1].username}</td>
      </tr>

      </tr>
    </g:each>
  </table>