<%@ page import="le.space.Contract" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="admin" />
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div id="koerper">
    <div id="inhalt">
      <h1><g:message code="default.show.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:form controller="public">
        <div class="buttons">
          <g:hiddenField name="id" value="${contractInstance?.id}" />
          <g:hiddenField name="_format" value="PDF" />
          <g:hiddenField name="_inline" value="false" />
          <g:hiddenField name="_name" value="contract_${contractInstance?.id}_${contractInstance?.customer?.company?.replace(' ','_')}" />
          <g:hiddenField name="_file" value="contract"  />
          <span class="button"><g:actionSubmit action="contractPdf"  value="${g.message(code:'contract.print')}" /></span>
        </div>
      </g:form>
      <g:form>
        <div class="buttons">
          <g:hiddenField name="id" value="${contractInstance?.id}" />
          <span class="button"><g:actionSubmit class="previous" action="previous" value="${message(code: 'default.button.previous.label', default: 'previous')}" /></span>
          <span class="button"><g:actionSubmit class="next" action="next" value="${message(code: 'default.button.next.label', default: 'next')}" /></span>
          <span class="button"><g:actionSubmit class="addFullPayment" action="addFullPayment" value="${message(code: 'default.button.addFullPayment.label', default: 'addFullPayment')}" /></span>
          <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
          <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
        </div>
        <div class="dialog">
          <table>
            <tr>
              <td valign="top">
                <table>
                  <tbody>
                    <tr class="prop">
                      <th align="left" valign="top" class="name"><g:message code="contract.id.label" default="Id" /></th>
                      <td valign="top" class="value">${fieldValue(bean: contractInstance, field: "id")}</td>
                      <th align="left" valign="top" class="name">&nbsp;</th>
                      <td valign="top" class="value"><g:if test="${contractInstance?.customer?.email}"><avatar:gravatar email="${contractInstance?.customer?.email}" defaultGravatarUrl="${createLinkTo(file:'favicon.ico')}"/></g:if></td>
                    </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.contractStart.label" default="Contract Start" /></th>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'quantity', 'errors')}"><calendar:datePicker dateFormat="%d.%m.%Y" name="contractStart" value="${contractInstance.contractStart}" defaultValue="${new Date()}" years="2009,2999"/></td>

            <th align="left" valign="top" class="name"><g:message code="contract.contractEnd.label" default="Contract End" /></th>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'quantity', 'errors')}"><calendar:datePicker dateFormat="%d.%m.%Y" name="contractEnd" value="${contractInstance.contractEnd}" defaultValue="${null}" years="2009,2999"/></td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name">&nbsp;</th>
            <td valign="top" >&nbsp;</td>

            <th align="left" valign="top" class="name"><g:message code="contract.cancelationDate.label" default="Cancelation Date" /></th>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'cancelationDate', 'errors')}"><calendar:datePicker dateFormat="%d.%m.%Y" name="cancelationDate" value="${contractInstance.cancelationDate}" defaultValue="${null}" years="2009,2999"/></td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.autoExtend.label" default="Auto Extend" /></th>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'quantity', 'errors')}">
            <g:radio name="autoExtend" value="true" checked="${contractInstance?.autoExtend}"/> <g:message code="contract.autoExtend.true" default="Auto Extend" /><br/>
            <g:radio name="autoExtend" value="false" checked="${!contractInstance?.autoExtend}"/> <g:message code="contract.autoExtend.false" default="Auto Extend" />
            </td>
            <th align="left" valign="top" class="name"><g:message code="contract.paymentMethod.label" default="Payment Method" /></th>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'quantity', 'errors')}">
            <g:select id="paymentMethod" name="paymentMethod"
                      valueMessagePrefix="contract.paymentMethod"
                      from="${contractInstance.constraints.paymentMethod.inList}" value="${contractInstance.paymentMethod}">
            </g:select>
            </td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name">
                <label for="quantity"><g:message code="contract.quantity.label" default="Quantity" /></label>
              </th>
              <th align="left" valign="top" class="value ${hasErrors(bean: contractInstance, field: 'quantity', 'errors')}">
                <input type="text" id="quantity" name="quantity" size="3" value="${fieldValue(bean:contractInstance,field:'quantity')}" />
              </th>

              <th align="left" valign="top" class="name">
                <label for="products"><g:message code="contract.products.label" default="Products" /></label>
              </th>
              <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'products', 'errors')}">
            <g:select name="products"
                      from="${le.space.Product.list()}"
                      size="5" multiple="yes" optionKey="id"
                      value="${contractInstance?.products}" />
            </td>
            </tr>

            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.conditions.label" default="Conditions" /></th>
            <td valign="top" class="value ${hasErrors(bean: contractInstance, field: 'conditions', 'errors')}">
            <g:textArea name="conditions" value="${contractInstance?.conditions}" rows="5" cols="25"/>
            </td>
            <td valign="top" class="name"></td>
            <td valign="top" class="value"></td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.amountNet.label" default="Amount Net" /></th>
            <td valign="top" class="value">€ ${formatNumber(number: contractInstance.amountNet, format: '##0.00')}</td>
            <th align="left" valign="top" class="name"><g:message code="contract.amountVAT.label" default="Amount VAT" /></th>
            <td valign="top" class="value">€ ${formatNumber(number: contractInstance.amountVAT, format: '##0.00')}</td>
            </tr>

            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.amountGross.label" default="Amount Gross" /></th>
            <td valign="top" class="value">€ ${formatNumber(number: contractInstance.amountGross, format: '##0.00')}</td>
            <th align="left" valign="top" class="name"><g:message code="contract.paid.label" default="Paid" /></th>
            <td valign="top" class="value"><g:checkBox name="paid" value="true" disabled="true" checked="${contractInstance.paid}"/></td>
            </tr>

            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.loginDays.label" default="loginDays" /></th>
            <td align="left" valign="top" class="value">${fieldValue(bean:contractInstance,field:'loginDays')}</td>
            <th align="left" valign="top" class="name"><g:message code="contract.lastLogin.label" default="lastLogin" /></th>
            <td align="left" valign="top" class="value"><g:formatDate date="${contractInstance.lastLogin}" format="dd.MM.yyyy HH:mm:ss"/></td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.amountTotal.label" default="amountTotal" /></th>
            <td valign="top" class="value">€ ${formatNumber(number: contractInstance.amountTotal, format: '##0.00')}</td>
            <th align="left" valign="top" class="name"><g:message code="contract.amountPaid.label" default="amountPaid" /></th>
            <td valign="top" class="value">€ ${formatNumber(number: contractInstance.amountPaid, format: '##0.00')}</td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.amountDue.label" default="amountDue" /></th>
            <td align="left" valign="top" class="value">€ ${formatNumber(number: contractInstance.amountDue, format: '##0.00')}</td>
            <th align="left" valign="top" class="name">&nbsp;</th>
            <td align="left" valign="top" class="value">&nbsp;</td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.valid.label" default="valid" /></th>
            <td valign="top" class="value"><g:checkBox name="paid" value="true" disabled="true" checked="${contractInstance.valid}"/></td>
            <th align="left" valign="top" class="name"><g:message code="contract.allowedLoginDaysLeft.label" default="allowedLoginDaysLeft" /></th>
            <td valign="top" class="value"><input type="text" id="allowedLoginDaysLeft" name="allowedLoginDaysLeft" size="3" value="${fieldValue(bean:contractInstance,field:'allowedLoginDaysLeft')}" />
            </td>
            </tr>
            <tr class="prop">
              <th align="left" valign="top" class="name"><g:message code="contract.dateCreated.label" default="dateCreated" /></th>
            <td valign="top" class="value"><g:formatDate date="${contractInstance.dateCreated}" format="dd.MM.yyyy HH:mm:ss"/><br/>by ${contractInstance?.createdBy?.username}</td>
            <th align="left" valign="top" class="name"><g:message code="contract.dateModified.label" default="dateModified" /></th>
            <td valign="top" class="value"><g:formatDate date="${contractInstance.dateModified}" format="dd.MM.yyyy HH:mm:ss"/><br/>by ${contractInstance?.modifiedBy?.username}</td>
            </tr>
            </tbody>
          </table></td>
          <td valign="top">
            <table>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.id.label" default="Customer Id" /></th>
              <td valign="top" class="value">${contractInstance?.customer?.id}</td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.company.label" default="Company" /></th>
              <td valign="top" class="value"><input type="text" id="company" name="company" size="20" value="${contractInstance?.customer?.company}" /></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.addressLine1.label" default="addressLine1" /></th>
              <td valign="top" class="value"><input type="text" id="addressLine1" name="addressLine1" size="20" value="${contractInstance?.customer?.addressLine1}" /></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.addressLine2.label" default="addressLine2" /></th>
              <td valign="top" class="value"><input type="text" id="addressLine2" name="addressLine2" size="20" value="${contractInstance?.customer?.addressLine2}" /></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.zip.label" default="zip" /></th>
              <td valign="top" class="value"><input type="text" id="zip" name="zip" size="10" value="${contractInstance?.customer?.zip}" /></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.city.label" default="city" /></th>
              <td valign="top" class="value"><input type="text" id="city" name="city" size="20" value="${contractInstance?.customer?.city}" /></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="customer.country.label" default="country" /></th>
              <th align="left" valign="top" class="value">
              <g:select name="country.id"  from="${le.space.Country.list()}"
                        value="${contractInstance?.customer?.country?.id}" noSelection="${['0':g.message(code:'contract.chooseSomething')]}"
                        optionKey="id"/></th>
              </tr>
              <tr>
                <th align="left" valign="top" class="name"><g:message code="customer.allowPublishNameOnWebsite.label" default="Paid" /></th>
              <td valign="top" class="value"><g:checkBox name="allowPublishNameOnWebsite" value="true"  checked="${contractInstance?.customer?.allowPublishNameOnWebsite}"/></td>
          </tr>
          <tr>
            <th align="left" valign="top" class="name"><g:message code="customer.reverseChargeSystem.label" default="Paid" /></th>
          <td valign="top" class="value"><g:checkBox name="reverseChargeSystem" value="true"  checked="${contractInstance?.customer?.reverseChargeSystem}"/>
          <input type="text" id="reverseChargeSystemID" name="reverseChargeSystemID" size="10" value="${contractInstance?.customer?.reverseChargeSystemID}" />
          </td>
          </tr>
          </table>
          </td></tr>
          </table>
        </div>
      </g:form>
      <div class="userLogins" id="userLogins">
        <g:render template="/shiroUser/userLogins"/>
      </div>
      <div class="shiroUserAdd" id="shiroUserAdd">
        <g:render template="/shiroUser/customerUsers" />
      </div>
      <div class="paymentAdd" id="paymentAdd">
        <g:render template="/payment/customerPayments" />
      </div>
    </div>
  </div>
</body>
</html>
