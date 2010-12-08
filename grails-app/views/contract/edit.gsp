<%@ page import="le.space.Contract" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="admin" />
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
  </div>
  <div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${contractInstance}">
      <div class="errors">
        <g:renderErrors bean="${contractInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${contractInstance?.id}" />
      <g:hiddenField name="version" value="${contractInstance?.version}" />
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="salutation"><g:message code="contract.salutation.label" default="Salutation" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'salutation', 'errors')}">
                <input type="text" id="salutation" name="salutation" value="${fieldValue(bean:contractInstance,field:'salutation')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="firstname"><g:message code="contract.firstname.label" default="Firstname" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'firstname', 'errors')}">
                <input type="text" id="firstname" name="firstname" value="${fieldValue(bean:contractInstance,field:'firstname')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="lastname"><g:message code="contract.lastname.label" default="Lastname" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'lastname', 'errors')}">
                <input type="text" id="lastname" name="lastname" value="${fieldValue(bean:contractInstance,field:'lastname')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="addressLine1"><g:message code="contract.addressLine1.label" default="Address Line1" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'addressLine1', 'errors')}">
                <input type="text" id="addressLine1" name="addressLine1" value="${fieldValue(bean:contractInstance,field:'addressLine1')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="addressLine2"><g:message code="contract.addressLine2.label" default="Address Line2" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'addressLine2', 'errors')}">
                <input type="text" id="addressLine2" name="addressLine2" value="${fieldValue(bean:contractInstance,field:'addressLine2')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="zip"><g:message code="contract.zip.label" default="Zip" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'zip', 'errors')}">
                <input type="text" id="zip" name="zip" value="${fieldValue(bean:contractInstance,field:'zip')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="city"><g:message code="contract.city.label" default="City" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'city', 'errors')}">
                <input type="text" id="city" name="city" value="${fieldValue(bean:contractInstance,field:'city')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="email"><g:message code="contract.email.label" default="Email" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'email', 'errors')}">
                <input type="text" id="email" name="email" value="${fieldValue(bean:contractInstance,field:'email')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="birthday"><g:message code="contract.birthday.label" default="Birthday" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'birthday', 'errors')}">
          <g:datePicker name="birthday" value="${contractInstance?.birthday}" noSelection="['':'']"></g:datePicker>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="tel1"><g:message code="contract.tel1.label" default="Tel1" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'tel1', 'errors')}">
              <input type="text" id="tel1" name="tel1" value="${fieldValue(bean:contractInstance,field:'tel1')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="telMobile"><g:message code="contract.telMobile.label" default="Tel Mobile" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'telMobile', 'errors')}">
              <input type="text" id="telMobile" name="telMobile" value="${fieldValue(bean:contractInstance,field:'telMobile')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fax"><g:message code="contract.fax.label" default="Fax" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'fax', 'errors')}">
              <input type="text" id="fax" name="fax" value="${fieldValue(bean:contractInstance,field:'fax')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="company"><g:message code="contract.company.label" default="Company" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'company', 'errors')}">
              <input type="text" id="company" name="company" value="${fieldValue(bean:contractInstance,field:'company')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="occupation"><g:message code="contract.occupation.label" default="Occupation" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'occupation', 'errors')}">
              <input type="text" id="occupation" name="occupation" value="${fieldValue(bean:contractInstance,field:'occupation')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="conditions"><g:message code="contract.conditions.label" default="Conditions" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'conditions', 'errors')}">
              <input type="text" id="conditions" name="conditions" value="${fieldValue(bean:contractInstance,field:'conditions')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="twitterName"><g:message code="contract.twitterName.label" default="Twitter Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'twitterName', 'errors')}">
              <input type="text" id="twitterName" name="twitterName" value="${fieldValue(bean:contractInstance,field:'twitterName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="facebookName"><g:message code="contract.facebookName.label" default="Facebook Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'facebookName', 'errors')}">
              <input type="text" id="facebookName" name="facebookName" value="${fieldValue(bean:contractInstance,field:'facebookName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="paymentMethod"><g:message code="contract.paymentMethod.label" default="Payment Method" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'paymentMethod', 'errors')}">
          <g:select id="paymentMethod" name="paymentMethod" from="${contractInstance.constraints.paymentMethod.inList}" value="${contractInstance.paymentMethod}" ></g:select>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contractStart"><g:message code="contract.contractStart.label" default="Contract Start" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'contractStart', 'errors')}">
          <g:datePicker name="contractStart" value="${contractInstance?.contractStart}" ></g:datePicker>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contractEnd"><g:message code="contract.contractEnd.label" default="Contract End" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'contractEnd', 'errors')}">
          <g:datePicker name="contractEnd" value="${contractInstance?.contractEnd}" noSelection="['':'']"></g:datePicker>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="autoExtend"><g:message code="contract.autoExtend.label" default="Auto Extend" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'autoExtend', 'errors')}">
          <g:checkBox name="autoExtend" value="${contractInstance?.autoExtend}" ></g:checkBox>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="allowPublishNameOnWebsite"><g:message code="contract.allowPublishNameOnWebsite.label" default="Allow Publish Name On Website" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'allowPublishNameOnWebsite', 'errors')}">
          <g:checkBox name="allowPublishNameOnWebsite" value="${contractInstance?.allowPublishNameOnWebsite}" ></g:checkBox>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="accountOwner"><g:message code="contract.accountOwner.label" default="Account Owner" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'accountOwner', 'errors')}">
              <input type="text" id="accountOwner" name="accountOwner" value="${fieldValue(bean:contractInstance,field:'accountOwner')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="accountNo"><g:message code="contract.accountNo.label" default="Account No" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'accountNo', 'errors')}">
              <input type="text" id="accountNo" name="accountNo" value="${fieldValue(bean:contractInstance,field:'accountNo')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="bankNo"><g:message code="contract.bankNo.label" default="Bank No" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'bankNo', 'errors')}">
              <input type="text" id="bankNo" name="bankNo" value="${fieldValue(bean:contractInstance,field:'bankNo')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="bankName"><g:message code="contract.bankName.label" default="Bank Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'bankName', 'errors')}">
              <input type="text" id="bankName" name="bankName" value="${fieldValue(bean:contractInstance,field:'bankName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="IBANNo"><g:message code="contract.IBANNo.label" default="IBANN o" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'IBANNo', 'errors')}">
              <input type="text" id="IBANNo" name="IBANNo" value="${fieldValue(bean:contractInstance,field:'IBANNo')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="BICNo"><g:message code="contract.BICNo.label" default="BICN o" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'BICNo', 'errors')}">
              <input type="text" id="BICNo" name="BICNo" value="${fieldValue(bean:contractInstance,field:'BICNo')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="directDebitPermission"><g:message code="contract.directDebitPermission.label" default="Direct Debit Permission" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'directDebitPermission', 'errors')}">
          <g:checkBox name="directDebitPermission" value="${contractInstance?.directDebitPermission}" ></g:checkBox>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="amountGross"><g:message code="contract.amountGross.label" default="Amount Gross" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'amountGross', 'errors')}">
              <input type="text" id="amountGross" name="amountGross" value="${fieldValue(bean:contractInstance,field:'amountGross')}" />
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="quantity"><g:message code="contract.quantity.label" default="Quantity" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'quantity', 'errors')}">
              <input type="text" id="quantity" name="quantity" value="${fieldValue(bean:contractInstance,field:'quantity')}" />
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="amountNet"><g:message code="contract.amountNet.label" default="Amount Net" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'amountNet', 'errors')}">
              <input type="text" id="amountNet" name="amountNet" value="${fieldValue(bean:contractInstance,field:'amountNet')}" />
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="products"><g:message code="contract.products.label" default="Products" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'products', 'errors')}">
          <g:select name="products"
                    from="${le.space.Product.list()}"
                    size="5" multiple="yes" optionKey="id"
                    value="${contractInstance?.products}" />

          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="amountVAT"><g:message code="contract.amountVAT.label" default="Amount VAT" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'amountVAT', 'errors')}">
              <input type="text" id="amountVAT" name="amountVAT" value="${fieldValue(bean:contractInstance,field:'amountVAT')}" />
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="url"><g:message code="contract.url.label" default="Url" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'url', 'errors')}">
              <input type="text" id="url" name="url" value="${fieldValue(bean:contractInstance,field:'url')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country"><g:message code="contract.country.label" default="Country" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'country', 'errors')}">
              <input type="text" id="country" name="country" value="${fieldValue(bean:contractInstance,field:'country')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country"><g:message code="contract.allowedLoginDaysLeft.label" default="allowedLoginDaysLeft" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'allowedLoginDaysLeft', 'errors')}">
              <input type="text" id="allowedLoginDaysLeft" name="allowedLoginDaysLeft" value="${fieldValue(bean:contractInstance,field:'allowedLoginDaysLeft')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="paid"><g:message code="contract.paid.label" default="Paid" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'paid', 'errors')}">
          <g:checkBox name="paid" value="${contractInstance?.paid}"></g:checkBox>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="selectedProducts"><g:message code="contract.selectedProducts.label" default="Selected Products" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'selectedProducts', 'errors')}">
              <input type="text" name="selectedProducts" id="selectedProducts" value="${fieldValue(bean:contractInstance,field:'selectedProducts')}" />
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </div>
    </g:form>
  </div>
</body>
</html>
