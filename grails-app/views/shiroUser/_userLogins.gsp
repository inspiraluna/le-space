<hr/>
<h2><g:message code="login.label" default="Login" /></h2>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:each in="${shiroUser?.logins}" status="i" var="login">
  <table>
    <g:hiddenField name="login.id" value="${login?.id}" />
    <g:hiddenField name="version" value="${login?.version}" />
    <tr>
      <th align="left"><g:message code="login.loginStart.label" default="paymentDate" /></th>
    <th align="left"><g:message code="login.ipAddress.label"  default="ipAddress" /></th>
    <th align="left"><g:message code="login.macAddress.label" default="macAddress" /></th>
    </tr>
    <tr>
      <td><g:datePicker precision="day" name="loginStart" value="${payment?.paymentDate}" defaultValue="${new Date()}" /></td>
    <td><input type="text" id="amount" name="ipAddress" size="10" value="${payment?.amount}" /></td>
    <td><input type="text" id="amount" name="macAddress" size="10" value="${payment?.amount}" /></td>
    </tr>
    <tr>
      <td colspan="4">
        <span class="button"><g:submitToRemote update="loginAdd" class="save" action="paymentUpdate" controller="payment" name="paymentUpdate" value="${g.message(code:'default.button.update.label')}" /></span>
        <span class="button"><g:submitToRemote update="loginAdd" class="paymentRemove" action="paymentRemove" controller="payment" name="paymentRemove" value="${g.message(code:'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
      </td>
    </tr>
  </table>
</g:each>
<table>
  <g:hiddenField name="login.id" value="${login?.id}" />
  <g:hiddenField name="version" value="${login?.version}" />
  <tr>
    <th align="left"><g:message code="login.loginStart.label" default="paymentDate" /></th>
<th align="left"><g:message code="login.ipAddress.label"  default="ipAddress" /></th>
<th align="left"><g:message code="login.macAddress.label" default="macAddress" /></th>
</tr>
<tr>
  <td><g:datePicker precision="day" name="loginStart" value="${payment?.paymentDate}" defaultValue="${new Date()}" /></td>
<td><input type="text" id="amount" name="ipAddress" size="10" value="${payment?.amount}" /></td>
<td><input type="text" id="amount" name="macAddress" size="10" value="${payment?.amount}" /></td>
</tr>
<tr>
  <td colspan="4">
    <span class="button"><g:submitToRemote update="loginAdd" class="loginAdd" action="loginAdd" controller="login" name="add" value="${g.message(code:'default.button.add.label')}" /></span>
  </td>
</tr>
</table>


