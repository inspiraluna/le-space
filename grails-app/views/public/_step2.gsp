<g:if test="${contract.paymentMethod==0}">
  <p><g:message code="contract.paymentMethod.0.message" /></p>
</g:if>
<g:if test="${contract.paymentMethod==1}">
  <table>
      <tr><td><g:message code="bankAccount.accountOwner.label" />:</td>
        <td class="value ${hasErrors(bean: bankAccount, field: 'accountOwner', 'errors')}"><g:textField name="accountOwner" value="${contract?.customer?.bankAccount?.accountOwner}" size="30" /></td></tr>
      <tr><td><g:message code="bankAccount.accountNo.label" />:</td>
        <td class="value ${hasErrors(bean: bankAccount, field: 'accountNo', 'errors')}"><g:textField name="accountNo" value="${contract?.customer?.bankAccount?.accountNo}" size="30"/></td></tr>
      <tr><td><g:message code="bankAccount.bankNo.label" />:</td>
        <td class="value ${hasErrors(bean: bankAccount, field: 'bankNo', 'errors')}"><g:textField name="bankNo" value="${contract?.customer?.bankAccount?.bankNo}" size="30"/></td></tr>
      <tr><td><g:message code="bankAccount.bankName.label" />:</td>
        <td class="value ${hasErrors(bean: bankAccount, field: 'bankName', 'errors')}"><g:textField name="bankName" value="${contract?.customer?.bankAccount?.bankName}" size="30"/></td></tr>
      <tr><td><g:message code="bankAccount.IBANNo.label" />:</td>
        <td class="value ${hasErrors(bean: bankAccount, field: 'IBANNo', 'errors')}"><g:textField name="IBANNo" value="${contract?.customer?.bankAccount?.IBANNo}" size="30"/></td></tr>
      <tr><td><g:message code="bankAccount.BICNo.label" />:</td>
        <td class="value ${hasErrors(bean: bankAccount, field: 'BICNo', 'errors')}"><g:textField name="BICNo" value="${contract?.customer?.bankAccount?.BICNo}" size="30" /></td></tr>
      <tr><td><g:message code="bankAccount.directDebitPermission.label" />:</td>
          <td class="value ${hasErrors(bean: bankAccount, field: 'directDebitPermission', 'errors')}"><g:checkBox name="directDebitPermission" value="${contract?.customer?.bankAccount?.directDebitPermission}" />&nbsp;
        <g:message code="bankAccount.directDebitPermissionText.label" />
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