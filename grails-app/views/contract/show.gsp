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
          <g:hiddenField name="id" value="${contract?.id}" />
          <g:hiddenField name="_format" value="PDF" />
          <g:hiddenField name="_inline" value="false" />
          <g:hiddenField name="_name" value="contract_${contract?.id}_${contract?.customer?.company?.replace(' ','_')}" />
          <g:hiddenField name="_file" value="contract"  />
          <span class="button"><g:actionSubmit action="contractPdf"  value="${g.message(code:'contract.print')}" /></span>
        </div>
      </g:form>

      <div class="dialog">
        <table>
          <tr>
            <td valign="top">
          <g:form>
            <div class="buttons">
              <g:hiddenField name="id" value="${contract?.id}" />
              <span class="button"><g:actionSubmit class="previous" action="previous" value="${message(code: 'default.button.previous.label', default: 'previous')}" /></span>
              <span class="button"><g:actionSubmit class="next" action="next" value="${message(code: 'default.button.next.label', default: 'next')}" /></span>
              <span class="button"><g:actionSubmit class="addFullPayment" action="addFullPayment" value="${message(code: 'default.button.addFullPayment.label', default: 'addFullPayment')}" /></span>
              <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
              <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
              <span class="button"><g:actionSubmit class="calculatePayments" action="calculatePayments" value="${message(code: 'default.button.calculate.label', default: 'Calculate Payments')}" /></span>

            </div>
            <table>
              <tbody>
                <tr class="prop">
                  <th align="left" valign="top" class="name"><g:message code="contract.id.label" default="Id" /></th>
              <td valign="top" class="value">${fieldValue(bean: contract, field: "id")}</td>
              <th align="left" valign="top" class="name">&nbsp;</th>
              <td valign="top" class="value"><g:if test="${contract?.customer?.email}"><avatar:gravatar email="${contract?.customer?.email}" defaultGravatarUrl="${createLinkTo(file:'favicon.ico')}"/></g:if></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.contractStart.label" default="Contract Start" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}"><calendar:datePicker dateFormat="%d.%m.%Y" name="contractStart" value="${contract.contractStart}" defaultValue="${new Date()}" years="2009,2999"/></td>

              <th align="left" valign="top" class="name"><g:message code="contract.contractEnd.label" default="Contract End" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}"><calendar:datePicker dateFormat="%d.%m.%Y" name="contractEnd" value="${contract.contractEnd}" defaultValue="${null}" years="2009,2999"/></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name">&nbsp;</th>
                <td valign="top" >&nbsp;</td>

                <th align="left" valign="top" class="name"><g:message code="contract.cancelationDate.label" default="Cancelation Date" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'cancelationDate', 'errors')}"><calendar:datePicker dateFormat="%d.%m.%Y" name="cancelationDate" value="${contract.cancelationDate}" defaultValue="${null}" years="2009,2999"/></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.autoExtend.label" default="Auto Extend" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}">
              <g:radio name="autoExtend" value="true" checked="${contract?.autoExtend}"/> <g:message code="contract.autoExtend.true" default="Auto Extend" /><br/>
              <g:radio name="autoExtend" value="false" checked="${!contract?.autoExtend}"/> <g:message code="contract.autoExtend.false" default="Auto Extend" />
              </td>
              <th align="left" valign="top" class="name"><g:message code="contract.paymentMethod.label" default="Payment Method" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}">
              <g:select id="paymentMethod" name="paymentMethod"
                        valueMessagePrefix="contract.paymentMethod"
                        from="${contract.constraints.paymentMethod.inList}" value="${contract.paymentMethod}">
              </g:select>
              </td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name">
                  <label for="quantity"><g:message code="contract.quantity.label" default="Quantity" /></label>
                </th>
                <th align="left" valign="top" class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}">
                  <input type="text" id="quantity" name="quantity" size="3" value="${fieldValue(bean:contract,field:'quantity')}" />
                </th>

                <th align="left" valign="top" class="name">
                  <label for="products"><g:message code="contract.products.label" default="Products" /></label>
                </th>
                <td valign="top" class="value ${hasErrors(bean: contract, field: 'products', 'errors')}">
              <g:select name="products"
                        from="${le.space.Product.list()}"
                        size="5" multiple="yes" optionKey="id"
                        value="${contract?.products}" />
              </td>
              </tr>

              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.conditions.label" default="Conditions" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'conditions', 'errors')}">
              <g:textArea name="conditions" value="${contract?.conditions}" rows="5" cols="25"/>
              </td>
              <th align="left" valign="top" class="name"><g:message code="contract.ConditionsExtra.label" default="ConditionsExtra" /></th>
              <td valign="top" class="value ${hasErrors(bean: contract, field: 'conditionsExtra', 'errors')}">
              <g:textArea name="conditionsExtra" value="${contract?.conditionsExtra}" rows="5" cols="25"/>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.amountNet.label" default="Amount Net" /></th>
              <td valign="top" class="value">€ ${formatNumber(number: contract.amountNet, format: '##0.00')}</td>
              <th align="left" valign="top" class="name"><g:message code="contract.amountVAT.label" default="Amount VAT" /></th>
              <td valign="top" class="value">€ ${formatNumber(number: contract.amountVAT, format: '##0.00')}</td>
              </tr>

              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.amountGross.label" default="Amount Gross" /></th>
              <td valign="top" class="value">€ ${formatNumber(number: contract.amountGross, format: '##0.00')}</td>
              <th align="left" valign="top" class="name"><g:message code="contract.paid.label" default="Paid" /></th>
              <td valign="top" class="value"><g:checkBox name="paid" value="true" disabled="true" checked="${contract.paid}"/></td>
              </tr>

              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.loginDays.label" default="loginDays" /></th>
              <td align="left" valign="top" class="value">${fieldValue(bean:contract,field:'loginDays')}</td>
              <th align="left" valign="top" class="name"><g:message code="contract.lastLogin.label" default="lastLogin" /></th>
              <td align="left" valign="top" class="value"><g:formatDate date="${contract.lastLogin}" format="dd.MM.yyyy HH:mm:ss"/></td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.amountTotal.label" default="amountTotal" /></th>
              <td valign="top" class="value">€ ${formatNumber(number: contract.customer.amountTotal, format: '##0.00')}</td>
              <th align="left" valign="top" class="name"><g:message code="contract.amountPaid.label" default="amountPaid" /></th>
              <td valign="top" class="value">€ ${formatNumber(number: contract.customer.amountPaid, format: '##0.00')}</td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.amountDue.label" default="amountDue" /></th>
              <td align="left" valign="top" class="value">€ ${formatNumber(number: contract.customer.amountDue, format: '##0.00')}</td>
              <th align="left" valign="top" class="name">&nbsp;</th>
              <td align="left" valign="top" class="value">&nbsp;</td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.valid.label" default="valid" /></th>
              <td valign="top" class="value"><g:checkBox name="paid" value="true" disabled="true" checked="${contract.valid}"/></td>
              <th align="left" valign="top" class="name"><g:message code="contract.allowedLoginDaysLeft.label" default="allowedLoginDaysLeft" /></th>
              <td valign="top" class="value"><input type="text" id="allowedLoginDaysLeft" name="allowedLoginDaysLeft" size="3" value="${fieldValue(bean:contract,field:'allowedLoginDaysLeft')}" />
              </td>
              </tr>
              <tr class="prop">
                <th align="left" valign="top" class="name"><g:message code="contract.dateCreated.label" default="dateCreated" /></th>
              <td valign="top" class="value"><g:formatDate date="${contract.dateCreated}" format="dd.MM.yyyy HH:mm:ss"/><br/>by ${contract?.createdBy?.username}</td>
              <th align="left" valign="top" class="name"><g:message code="contract.dateModified.label" default="dateModified" /></th>
              <td valign="top" class="value"><g:formatDate date="${contract.dateModified}" format="dd.MM.yyyy HH:mm:ss"/><br/>by ${contract?.modifiedBy?.username}</td>
              </tr>
              </tbody>
            </table>
          </g:form>
          </td>
          <td valign="top">
            <div class="customerData" id="customerData">
              <g:render template="/customer/customerData"/>
            </div>
            <div class="bankAccount" id="bankAccount">
              <g:render template="/customer/bankAccount"/>
            </div>
          </td>

          </tr>
        </table>
      </div>
      <div class="customerContracts" id="customerContracts">
        <g:render template="/customer/customerContracts" model="['numbers':true,'contract':contract]" />
      </div>
      <div class="userLogins" id="userLogins">
        <g:render template="/login/userLogins"/>
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
