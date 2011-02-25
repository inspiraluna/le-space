<hr/>
<h2><g:message code="payments.label" default="Payments" /></h2>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:each in="${contract?.customer?.payments}" status="i" var="payment">
  <g:form>
    <table>
      <g:hiddenField name="id" value="${payment?.id}" />
      <g:hiddenField name="contract.id" value="${contract?.id}" />
      <g:hiddenField name="version" value="${payment?.version}" />
      <tr>
        <th align="left"><g:message code="payment.amount.label" default="amount" /></th>
      <th align="left"><g:message code="payment.paymentDate.label" default="paymentDate" /></th>
      <th align="left"><g:message code="payment.paymentMethod.label" default="paymentMethod" /></th>
      </tr>

      <tr>
        <td><input type="text" id="amount" name="amount" size="10" value="${formatNumber(number:payment?.amount, format: '#,##0.00')}" /></td>
        <td><g:datePicker precision="day" name="paymentDate" value="${payment?.paymentDate}" defaultValue="${new Date()}" /></td>
      <td><g:select name="paymentMethod" from="${[0,1,2,3]}" valueMessagePrefix="contract.paymentMethod" /></td>
      </tr>
      <tr>
        <td colspan="4">          
          <span class="button"><g:submitToRemote update="paymentAdd" class="save" action="paymentUpdate" controller="payment" name="paymentUpdate" value="${g.message(code:'default.button.update.label')}" /></span>
          <span class="button"><g:submitToRemote update="paymentAdd" class="paymentRemove" action="paymentRemove" controller="payment" name="paymentRemove" value="${g.message(code:'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </td>
      </tr>
    </table>
  </g:form>
</g:each>
<g:form>
  <table>
    <g:hiddenField name="customer.id" value="${contract?.customer?.id}" />
    <g:hiddenField name="contract.id" value="${contract?.id}" />
    <g:hiddenField name="version" value="${payment?.version}" />
    <tr>
      <th align="left"><g:message code="payment.amount.label" default="amount" /></th>
      <th align="left"><g:message code="payment.paymentDate.label" default="paymentDate" /></th>
      <th align="left"><g:message code="payment.paymentMethod.label" default="paymentMethod" /></th>
    </tr>
    <tr>
      <td><input type="text" id="amount" name="amount" size="10" value="${formatNumber(number:payment?.amount, format: '#,##0.00')}" /></td>
      <td><g:datePicker precision="day" name="paymentDate" value="${payment?.paymentDate}" defaultValue="${new Date()}" /></td>
    <td><g:select name="paymentMethod" from="${[0,1,2,3]}" valueMessagePrefix="contract.paymentMethod" /></td>
    </tr>
    <tr>
      <td colspan="4">
        <span class="button"><g:submitToRemote update="paymentAdd" class="paymentAdd" action="paymentAdd" controller="payment" name="add" value="${g.message(code:'default.button.add.label')}" /></span>
      </td>
    </tr>
  </table>
</g:form>

