<g:form>
  <g:hiddenField name="id" value="${contract?.customer?.id}" />
  <g:hiddenField name="contract.id" value="${contract?.id}" />
  <g:hiddenField name="version" value="${contract?.customer?.version}" />
  <table>
    <tr><th align="left"><g:message code="customer.id.label" />*:</th><td class="value">${contract?.customer?.id}</td></tr>
    <tr><th align="left"><g:message code="customer.company.label" />*:</th><td class="value ${hasErrors(bean: shiroUser, field: 'company', 'errors')}"><g:textField name="company" value="${contract?.customer?.company}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.addressLine1.label" />*:</th><td class="value ${hasErrors(bean: customer, field: 'addressLine1', 'errors')}"><g:textField name="addressLine1" value="${contract?.customer?.addressLine1}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.addressLine2.label" />:</th><td class="value ${hasErrors(bean: customer, field: 'addressLine2', 'errors')}"><g:textField name="addressLine2" value="${contract?.customer?.addressLine2}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.zip.label" />*:</th><td class="value ${hasErrors(bean: customer, field: 'zip', 'errors')}"><g:textField name="zip" value="${contract?.customer?.zip}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.city.label" />*:</th><td class="value ${hasErrors(bean: customer, field: 'city', 'errors')}"><g:textField name="city" value="${contract?.customer?.city}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.country.label" />*:</th><td class="value ${hasErrors(bean: customer, field: 'country', 'errors')}"><g:select name="country.id"  from="${le.space.Country.list()}"
                                                                                                                                                                value="${contract?.customer?.country?.id}" noSelection="${['0':g.message(code:'contract.chooseSomething')]}"
                                                                                                                                                                optionKey="id"  /></td></tr>
    <tr><th align="left"><g:message code="customer.tel1.label" />:</th><td class="value ${hasErrors(bean: customer, field: 'tel1', 'errors')}"><g:textField name="tel1" value="${contract?.customer?.tel1}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.fax.label" />:</th><td class="value ${hasErrors(bean: customer, field: 'fax', 'errors')}"><g:textField name="fax" value="${contract?.customer?.tel1}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.url.label" />:</th><td class="value ${hasErrors(bean: customer, field: 'url', 'errors')}"><g:textField name="url" value="${contract?.customer?.url}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.fax.label" />:</th><td class="value ${hasErrors(bean: customer, field: 'fax', 'errors')}"><g:textField name="fax" value="${contract?.customer?.tel1}" size="30" /></td></tr>
    <tr><th align="left"><g:message code="customer.allowPublishNameOnWebsite.label" />:</th><td><g:checkBox name="allowPublishNameOnWebsite" value="${contract?.customer?.allowPublishNameOnWebsite}" /><g:message code="customer.allowPublishNameOnWebsite_ext.label" /></td></tr>
    <tr><th  align="left" class="value ${hasErrors(bean: customer, field: 'reverseChargeSystem', 'errors')}"><g:message code="customer.reverseChargeSystem.label" />:</th><td><g:checkBox name="reverseChargeSystem" value="${contract?.customer?.reverseChargeSystem}"/>
    &nbsp;<g:message code="customer.reverseChargeSystemID.label" />:&nbsp;<g:textField name="reverseChargeSystemID" value="${contract?.customer?.reverseChargeSystemID}" />&nbsp;
    </td></tr>
    <tr><th align="left"><g:message code="customer.debitNo.label" />:</th><td class="value ${hasErrors(bean: shiroUser, field: 'debitNo', 'errors')}"><g:textField name="debitNo" value="${contract?.customer?.debitNo}" size="30" /></td></tr>

    <tr><td valign="top" colspan="2"  align="middle"><g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if></td></tr>
    <tr><th colspan="2" align="left"><span class="button"><g:submitToRemote update="customerData" class="customerData" action="customerData" controller="customer" name="customerData" value="${g.message(code:'default.button.update.label')}" /></span></th></tr
  </table>
</g:form>