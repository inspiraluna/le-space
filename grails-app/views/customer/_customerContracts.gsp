
<table>
  <thead>
    <tr>
  <g:sortableColumn align="left" valign="top" property="id" title="${message(code: 'contract.id.label', default: 'Id')}" />
  <g:sortableColumn align="left" valign="top" property="contractStart" title="${message(code: 'contract.contractStart.label', default: 'Contract Start')}" />
  <g:sortableColumn align="left" valign="top" property="contractEnd" title="${message(code: 'contract.contractEnd.label', default: 'Contract End')}" />
  <g:sortableColumn align="left" valign="top" property="autoExtend" title="${message(code: 'contract.autoExtend.label', default: 'autoextend')}" />
  <g:sortableColumn align="left" valign="top" property="paid" title="${message(code: 'contract.paid.label', default: 'paid')}" />
  <g:sortableColumn align="left" valign="top" property="valid" title="${message(code: 'contract.valid.label', default: 'valid')}" />
  <g:sortableColumn align="left" valign="top" property="amountGross" title="${message(code: 'contract.amountGross.label', default: 'amountGross')}" />
  <g:sortableColumn align="left" valign="top" property="selectedProducts" title="${message(code: 'contract.selectedProducts.label', default: 'Selected Products')}" />
  <g:sortableColumn align="left" valign="top" property="allowedLoginDaysLeft" title="${message(code: 'contract.allowedLoginDaysLeft', default: 'Logins left')}" />
  <g:sortableColumn align="left" valign="top" property="loginDays" title="${message(code: 'contract.loginDays', default: 'number of logins')}" />
  <g:sortableColumn align="left" valign="top" property="lastLogin" title="${message(code: 'contract.lastLogin', default: 'lastLogin')}" />
</tr>
</thead>
<tbody>
<g:each in="${contractList}" status="i" var="contractInstance">
  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    <td valign="top"><g:link action="show" id="${contractInstance.id}">${fieldValue(bean: contractInstance, field: "id")}</g:link></td>
  <td valign="top" ><g:formatDate date="${contractInstance.contractStart}" format="dd.MM.yyyy"/></td>
  <td valign="top" ><g:formatDate date="${contractInstance.contractEnd}" format="dd.MM.yyyy"/></td>
  <td valign="top" >${fieldValue(bean: contractInstance, field: "autoExtend")}</td>
  <td valign="top" >${fieldValue(bean: contractInstance, field: "paid")}</td>
  <td valign="top" >${fieldValue(bean: contractInstance, field: "valid")}</td>
  <td valign="top" align="right"><g:formatNumber number="${contractInstance.amountGross}" format="€ ###,##0.00" /></td>
  <td valign="top" align="left">${fieldValue(bean: contractInstance, field: "selectedProducts")}</td>
  <td valign="top" align="right">${fieldValue(bean: contractInstance, field: "allowedLoginDaysLeft")}</td>
  <td valign="top" align="right">${fieldValue(bean: contractInstance, field: "loginDays")}</td>
  <td valign="top" align="left"><g:formatDate date="${contractInstance.lastLogin}" format="dd.MM.yyyy hh:mm:ss"/></td>
  </tr>
</g:each>
</tbody>
</table>
<g:form name="contract">
  <g:hiddenField name="customer.id" value="${customer?.id}" />
  <table>
    <tr><th align="left"><g:message code="contract.contractStart.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'contractStart', 'errors')}">
    <calendar:datePicker
      dateFormat="%d.%m.%Y"
      name="contractStart"
      defaultValue="${new Date()}"
      value="${contract?.contractStart}"/>
    </td>
    </tr>
    <tr><th align="left"><g:message code="contract.quantity.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}">
    <g:select name="quantity"
              from="${1..100}"
              value="${contract?.quantity}"
              onChange="loadSubOptions(document.contract.product.value);" /></td></tr>

    <tr><th align="left"><g:message code="contract.paymentMethod.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'paymentMethod', 'errors')}">
    <g:radio name="paymentMethod" value="0" checked="${contract?.paymentMethod==0}"/>&nbsp;<g:message code="contract.paymentMethod.0" /><br>
    <g:radio name="paymentMethod" value="1" checked="${contract?.paymentMethod==1}"/>&nbsp;<g:message code="contract.paymentMethod.1" /><br>
    <!-- <g:radio name="paymentMethod" value="2" checked="${!contract?.paymentMethod==2}"/>&nbsp;<g:message code="contract.paymentMethod.2" /><br>') -->
    </td></tr>
    <tr><th align="left"><g:message code="contract.autoExtend.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'autoExtend', 'errors')}">
    <g:radio name="autoExtend" value="true" checked="${contract?.autoExtend}" onChange="autoExtend(this.value);"/>&nbsp;<g:message code="contract.autoExtend.true" /><br>
    <g:radio name="autoExtend" value="false" checked="${!contract?.autoExtend}" onChange="autoExtend(this.value);"/>&nbsp;<g:message code="contract.autoExtend.false" />
    </td></tr>
    <tr><th  align="left" class="value ${hasErrors(bean: customer, field: 'reverseChargeSystem', 'errors')}"><g:message code="customer.reverseChargeSystem.label" />:</td><td><g:checkBox name="reverseChargeSystem" value="${contract?.customer?.reverseChargeSystem}" onChange="loadSubOptions(document.contract.product.value);"/>
    &nbsp;<g:message code="customer.reverseChargeSystemID.label" />:&nbsp;<g:textField name="reverseChargeSystemID" value="${contract?.customer?.reverseChargeSystemID}" />&nbsp;
    </td></tr>
    <tr><th align="left"><g:message code="contract.products.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'products', 'errors')}">
    <g:select name="product"  from="${le.space.Product.findAll('from Product as p where p.option is null and p.publicProduct=true')}"
              valueMessagePrefix="contract.product"
              value="${(contract?.getProducts() && contract?.getProducts()?.size()>0)?(contract.getProducts().toArray().sort{it.id})[0].id:null}"
              noSelection="${['0':g.message(code:'contract.chooseSomething')]}"
              optionKey="id" onChange="loadSubOptions(this.value);" /></td>
    </tr>
    <tr><th colspan="2"  align="center"><g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if></th></tr>
  </table>
  <g:javascript>
			loadSubOptions = function(optionId) {
				new Ajax.Updater('optionsOfProduct', '${createLinkTo(dir:'public/optionsOfProduct/')}'+optionId, {
			  		parameters: {
    id: optionId,
    autoExtend: document.contract.autoExtend.value,
    product: document.contract.product.value,
    contractStart: document.contract.contractStart.value,
    paymentMethod:document.contract.paymentMethod.value,
    reverseChargeSystem:document.contract.reverseChargeSystem.checked,
    reverseChargeSystemID:document.contract.reverseChargeSystemID.value,
    quantity:document.contract.quantity.value
    }
    });
    }
			loadSum = function(optionName,optionValue) {
				new Ajax.Updater('sum', '${createLinkTo(dir:'public/addOption/')}', {
			  		parameters: { optionName: optionName, optionValue: optionValue }
    });
    }
			autoExtend = function(optionValue){
				new Ajax.Updater('optionsOfProduct', '${createLinkTo(dir:'public/autoExtend/')}', {
			  		parameters: { autoExtend: optionValue }
    });
    }
  </g:javascript>
  <div id="optionsOfProduct">
    <g:render template="/public/optionsOfProduct" />
  </div>
</g:form>
<table>
  <tr><th colspan="2"  align="center"><span class="button"><g:submitToRemote update="customerContracts" class="userContracts" action="addContract" controller="contract" name="addContract" value="${g.message(code:'contract.addContract.label')}" /></span></th></tr>
</table>