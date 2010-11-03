<g:if test="${contract.paymentMethod==0}">
  <p><g:message code="contract.paymentMethod.0.message" /></p>
</g:if>
<g:if test="${contract.paymentMethod==1}">
  <table>
      <tr><td><g:message code="contract.accountOwner" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'accountOwner', 'errors')}"><g:textField name="accountOwner" value="${contract?.customer?.accountOwner}" /></td></tr>
      <tr><td><g:message code="contract.accountNo" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'accountNo', 'errors')}"><g:textField name="accountNo" value="${contract?.customer?.accountNo}" /></td></tr>
      <tr><td><g:message code="contract.bankNo" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'bankNo', 'errors')}"><g:textField name="bankNo" value="${contract?.customer?.bankNo}" /></td></tr>
      <tr><td><g:message code="contract.bankName" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'bankName', 'errors')}"><g:textField name="bankName" value="${contract?.customer?.bankName}" /></td></tr>
      <tr><td><g:message code="contract.IBANNo" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'IBANNo', 'errors')}"><g:textField name="IBANNo" value="${contract?.customer?.IBANNo}" /></td></tr>
      <tr><td><g:message code="contract.BICNo" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'BICNo', 'errors')}"><g:textField name="BICNo" value="${contract?.customer?.BICNo}" /></td></tr>
      <tr><td><g:message code="contract.directDebitPermission" />:</td>
        <td class="value ${hasErrors(bean: contract, field: 'directDebitPermission', 'errors')}"><g:checkBox name="directDebitPermission" value="${contract?.customer?.directDebitPermission}" />&nbsp;
        <g:message code="contract.directDebitPermissionText" />
        </td></tr>
  </table>
</g:if>
<g:if test="${contract.paymentMethod==2}">
<paypal:button
  itemName="${contract.products}"
  itemNumber="${contract.id}"
  amount="${formatNumber(number: contract.amountNet, format: '##0.00')}"
  tax="${formatNumber(number: contract.amountVAT, format: '##0.00')}"
  currency="EUR"
  buyerId="${contract.id}"
  />
</g:if>

<tr><td colspan="2"><g:submitToRemote update="update"  action="step1" controller="public" name="back" value="${g.message(code:'contract.back')}" />
<tr><td colspan="2"><g:submitToRemote update="update"  action="step3" controller="public" name="forward" value="${g.message(code:'contract.forward')}" /></td></tr>

