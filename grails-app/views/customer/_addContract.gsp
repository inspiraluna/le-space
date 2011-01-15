<g:form name="contract">
  <g:hiddenField name="customer.id" value="${contract?.customer?.id}" />
  <table>
    <tr><th align="left"><g:message code="contract.contractStart.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'contractStart', 'errors')}">
    <calendar:datePicker
      dateFormat="%d.%m.%Y"
      name="contractStart"
      defaultValue="${new Date()}"
      />
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
    <tr><th align="left"><g:message code="contract.products.label" />:</th><td class="value ${hasErrors(bean: contract, field: 'products', 'errors')}">
      
    <g:select name="product"  from="${le.space.Product.findAll('from Product as p where p.option is null and p.publicProduct=true')}"
              noSelection="${['0':g.message(code:'contract.chooseSomething')]}"
              optionKey="id" onChange="loadSubOptions(this.value);" /></td>
    </tr>
   
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
  <table>
  <tr><th colspan="2"  align="center"><g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if></th></tr>
  <tr><th colspan="2"  align="center"><span class="button"><g:submitToRemote update="addContract" class="userContracts" action="addContract" controller="customer" name="addContract" value="${g.message(code:'contract.addContract.label')}" /></span></th></tr>
</table>
</g:form>