<g:form>
  <g:hiddenField name="id" value="${contract?.customer?.id}" />
  <g:hiddenField name="contract.id" value="${contract?.id}" />
  <g:hiddenField name="version" value="${contract?.customer?.version}" />
  <table>
    <tr><td><g:message code="bankAccount.accountOwner.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'accountOwner', 'errors')}"><g:textField name="accountOwner" value="${contract?.customer?.bankAccount?.accountOwner}" /></td></tr>
    <tr><td><g:message code="bankAccount.accountNo.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'accountNo', 'errors')}"><g:textField name="accountNo" value="${contract?.customer?.bankAccount?.accountNo}" /></td></tr>
    <tr><td><g:message code="bankAccount.bankNo.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'bankNo', 'errors')}"><g:textField name="bankNo" value="${contract?.customer?.bankAccount?.bankNo}" /></td></tr>
    <tr><td><g:message code="bankAccount.bankName.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'bankName', 'errors')}"><g:textField name="bankName" value="${contract?.customer?.bankAccount?.bankName}" /></td></tr>
    <tr><td><g:message code="bankAccount.IBANNo.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'IBANNo', 'errors')}"><g:textField name="IBANNo" value="${contract?.customer?.bankAccount?.IBANNo}" /></td></tr>
    <tr><td><g:message code="bankAccount.BICNo.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'BICNo', 'errors')}"><g:textField name="BICNo" value="${contract?.customer?.bankAccount?.BICNo}" /></td></tr>
    <tr><td><g:message code="bankAccount.directDebitPermission.label" />:</td>
    <td class="value ${hasErrors(bean: bankAccount, field: 'directDebitPermission', 'errors')}"><g:checkBox name="directDebitPermission" value="${contract?.customer?.bankAccount?.directDebitPermission}" />&nbsp;
    <g:message code="bankAccount.directDebitPermissionText.label" />
    </td></tr>
    <tr><td valign="top" align="left"><g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if></td></tr>
    <tr><th colspan="2" align="left"><span class="button"><g:submitToRemote update="bankAccount" class="bankAccount" action="bankAccount" controller="customer" name="bankAccount" value="${g.message(code:'default.button.update.label')}" /></span></th></tr
  </table>
</g:form>