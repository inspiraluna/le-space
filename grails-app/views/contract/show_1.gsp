<%@ page import="le.space.Contract" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="admin" />
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
  </div>
  <div class="body">
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${contractInstance?.id}" />
        <span class="button"><g:actionSubmit class="previous" action="previous" value="${message(code: 'default.button.previous.label', default: 'previous')}" /></span>
        <span class="button"><g:actionSubmit class="next" action="next" value="${message(code: 'default.button.next.label', default: 'next')}" /></span>
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
        <span class="button"><g:actionSubmit class="duplicate" action="duplicate" value="${message(code: 'default.button.duplicate.label', default: 'Duplicate')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </g:form>

      <g:form controller="public">
        <g:hiddenField name="id" value="${contractInstance?.id}" />
        <g:hiddenField name="_format" value="PDF" />
        <g:hiddenField name="_inline" value="false" />
        <g:hiddenField name="_name" value="contract" />
        <g:hiddenField name="_file" value="contract"  />
        <span class="button"><g:actionSubmit action="contractPdf" value="${g.message(code:'contract.print')}" /></span>
      </g:form>
    </div>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="contract.id.label" default="Id" /></td>
            <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "id")}</td>
            <td valign="top" class="name"><g:message code="contract.company.label" default="Company" /></td>
            <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.company")}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="contract.addressLine1.label" default="Address Line1" /></td>
            <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.addressLine1")}</td>
            <td valign="top" class="name"><g:message code="contract.addressLine2.label" default="Address Line2" /></td>
            <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.addressLine2")}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="contract.zip.label" default="Zip" /></td>
            <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.zip")}</td>
            <td valign="top" class="name"><g:message code="contract.city.label" default="City" /></td>
            <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.city")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.country.label" default="Country" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.country")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.tel1.label" default="Tel1" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.tel1")}</td>
        <td valign="top" class="name"><g:message code="contract.fax.label" default="Fax" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.fax")}</td>
        </tr>

       
        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.url.label" default="Url" /></td>
          <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.url")}</td>
        </tr>

        
        </tr>

        <td valign="top" class="name"><g:message code="contract.paymentMethod.label" default="Payment Method" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "paymentMethod")}</td>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.contractStart.label" default="Contract Start" /></td>
        <td valign="top" class="value"><g:formatDate date="${contractInstance?.contractStart}" /></td>
        <td valign="top" class="name"><g:message code="contract.contractEnd.label" default="Contract End" /></td>
        <td valign="top" class="value"><g:formatDate date="${contractInstance?.contractEnd}" /></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.autoExtend.label" default="Auto Extend" /></td>
        <td valign="top" class="value"><g:formatBoolean boolean="${contractInstance?.autoExtend}" /></td>
        <td valign="top" class="name"><g:message code="contract.allowPublishNameOnWebsite.label" default="Allow Publish Name On Website" /></td>
        <td valign="top" class="value"><g:formatBoolean boolean="${contractInstance?.customer.allowPublishNameOnWebsite}" /></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.accountOwner.label" default="Account Owner" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.accountOwner")}</td>
        <td valign="top" class="name"><g:message code="contract.accountNo.label" default="Account No" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.accountNo")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.bankNo.label" default="Bank No" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.bankNo")}</td>
        <td valign="top" class="name"><g:message code="contract.bankName.label" default="Bank Name" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.bankName")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.IBANNo.label" default="IBANNo" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.IBANNo")}</td>
        <td valign="top" class="name"><g:message code="contract.BICNo.label" default="BICN o" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "customer.BICNo")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.directDebitPermission.label" default="Direct Debit Permission" /></td>
        <td valign="top" class="value"><g:formatBoolean boolean="${contractInstance?.customer.directDebitPermission}" /></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.quantity.label" default="Quantity" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "quantity")}</td>
        <td valign="top" class="name"><g:message code="contract.products.label" default="Products" /></td>
        <td valign="top" style="text-align: left;" class="value">
          <ul>
            <g:each in="${contractInstance.products}" var="p">
              <li><g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
            </g:each>
          </ul>
        <td valign="top" class="name"><g:message code="contract.selectedProducts.label" default="Selected Products" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "selectedProducts")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.amountNet.label" default="Amount Net" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "amountNet")}</td>
        <td valign="top" class="name"><g:message code="contract.amountVAT.label" default="Amount VAT" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "amountVAT")}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="contract.amountGross.label" default="Amount Gross" /></td>
        <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "amountGross")}</td>
        <td valign="top" class="name"><g:message code="contract.paid.label" default="Paid" /></td>
        <td valign="top" class="value"><g:formatBoolean boolean="${contractInstance?.paid}" /></td>
        </tr>

        <tr class="prop">

          <td valign="top" class="name"><g:message code="contract.conditions.label" default="Conditions" /></td>
         <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "conditions")}</td>

          <td valign="top" class="name"><g:message code="contract.payments.label" default="Payments" /></td>
          <td valign="top" style="text-align: left;" class="value">
          <ul><g:each in="${le.space.Payment.findAllByContract(contractInstance)}" var="p"><li><g:link controller="payment" action="show" id="${p.id}">${p?.encodeAsHTML()}
              </g:link></li></g:each>
          </ul>
        </td>

        <td valign="top" class="name"><g:message code="contract.login.label" default="Logins" /></td>
        <td valign="top" style="text-align: left;" class="value">
          <ul><g:each in="${contractInstance.logins}" var="l"><li><g:link controller="login" action="show" id="${l.id}">${l?.encodeAsHTML()}
              </g:link></li></g:each>
          </ul>
        </td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${contractInstance?.id}" />
        <span class="button"><g:actionSubmit class="previous" action="previous" value="${message(code: 'default.button.previous.label', default: 'previous')}" /></span>
        <span class="button"><g:actionSubmit class="next" action="next" value="${message(code: 'default.button.next.label', default: 'next')}" /></span>
        <span class="button"><g:actionSubmit class="addFullPayment" action="addFullPayment" value="${message(code: 'default.button.addFullPayment.label', default: 'addFullPayment')}" /></span>
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </g:form>

      <g:form controller="public">
        <g:hiddenField name="id" value="${contractInstance?.id}" />
        <g:hiddenField name="_format" value="PDF" />
        <g:hiddenField name="_inline" value="false" />
        <g:hiddenField name="_name" value="contract" />
        <g:hiddenField name="_file" value="contract"  />
        <span class="button"><g:actionSubmit action="contractPdf" value="${g.message(code:'contract.print')}" /></span>
      </g:form>
    </div>
  </div>
</body>
</html>
