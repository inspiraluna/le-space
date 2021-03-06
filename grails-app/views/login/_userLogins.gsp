<hr/>
<h2><g:message code="login.label" default="Login" /></h2>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<table>
  <tr>
    <th nowrap><g:message code="login.no.label" default="no" /></th>
    <th align="left"><g:message code="login.loginStart.label" default="loginStart" /></th>
    <th align="left"><g:message code="login.shiroUser.label" default="shiroUser" /></th>
    <th align="left">&nbsp;</th>
</tr>
<g:each in="${loginList}" status="j" var="login">
  <tr>
    <td nowrap>${loginList.size()-j}</td>
    <td nowrap>${login[0]}</td>
    <td nowrap>${login[1].username} (${login[1].id})</td>
    <td nowrap>
        <g:form controller="Login">
          <g:hiddenField name="id" value="${login[2]?.id}" /><g:hiddenField name="contract.id" value="${contract?.id}" /><g:submitToRemote update="userLogins" class="removeLogin" action="removeLogin" controller="login" name="removeLogin" value="${g.message(code:'default.button.delete.label')}" /></g:form></td>
  </tr>
</g:each>
</table>
<g:form>
  <table>
    <g:hiddenField name="customer.id" value="${contract?.customer?.id}" />
    <g:hiddenField name="contract.id" value="${contract?.id}" />
    <g:hiddenField name="version" value="${payment?.version}" />
    <tr>
      <th align="left"><g:message code="login.loginStart.label" default="loginStart" /></th>
      <th align="left"><g:message code="login.shiroUser.label" default="shiroUser" /></th>
    </tr>
    <tr>
      <td nowrap><g:datePicker precision="day" name="loginStart" precision="minute" value="${payment?.paymentDate}" defaultValue="${new Date()}" /></td>
    <td>
    <g:select name="user.id"
                  from="${contract?.customer.shiroUsers}"
                  optionKey="id"
                  value="username" /></td>
    </tr>
    <tr>
      <td colspan="4">
        <span class="button"><g:submitToRemote update="userLogins" class="addLogin" action="addLogin" controller="login" name="addLogin" value="${g.message(code:'default.button.add.label')}" /></span>
      </td>
    </tr>
  </table>
</g:form>
