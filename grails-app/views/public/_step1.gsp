<p><g:message code="contract.intro1" /></p>
<h2>Diese Anmeldung ist einer frühen Alpha Version. Bitte nur nach persönlicher Absprache mit dem Coworking Space verwenden.</h2>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:hasErrors bean="${contract}">
  <div class="errors">
    <g:renderErrors bean="${contract}" as="list" />
  </div>
</g:hasErrors>
<g:hasErrors bean="${customer}">
  <div class="errors">
    <g:renderErrors bean="${customer}" as="list" />
  </div>
</g:hasErrors>
<g:hasErrors bean="${shiroUser}">
  <div class="errors">
    <g:renderErrors bean="${shiroUser}" as="list" />
  </div>
</g:hasErrors>
<table>
<tr><td><g:message code="shiroUser.salutation.label" />*:</td><td class="value ${hasErrors(bean: shiroUser, field: 'salutation', 'errors')}"><g:textField name="salutation" value="${shiroUser.salutation}" /></td></tr>
<tr><td><g:message code="customer.company.label" />*:</td><td class="value ${hasErrors(bean: shiroUser, field: 'company', 'errors')}"><g:textField name="company" value="${contract?.customer?.company}" /></td></tr>
<tr><td><g:message code="shiroUser.firstname.label" />*:</td><td class="value ${hasErrors(bean: shiroUser, field: 'firstname', 'errors')}"><g:textField name="firstname" value="${shiroUser.firstname}" /></td></tr>
<tr><td><g:message code="shiroUser.lastname.label" />*:</td><td class="value ${hasErrors(bean: shiroUser, field: 'lastname', 'errors')}"><g:textField name="lastname" value="${shiroUser.lastname}" /></td></tr>
<tr><td><g:message code="customer.addressLine1.label" />*:</td><td class="value ${hasErrors(bean: customer, field: 'addressLine1', 'errors')}"><g:textField name="addressLine1" value="${contract?.customer?.addressLine1}" /></td></tr>
<tr><td><g:message code="customer.addressLine2.label" />:</td><td class="value ${hasErrors(bean: customer, field: 'addressLine2', 'errors')}"><g:textField name="addressLine2" value="${contract?.customer?.addressLine2}" /></td></tr>
<tr><td><g:message code="customer.zip.label" />*:</td><td class="value ${hasErrors(bean: customer, field: 'zip', 'errors')}"><g:textField name="zip" value="${contract?.customer?.zip}" /></td></tr>
<tr><td><g:message code="customer.city.label" />*:</td><td class="value ${hasErrors(bean: customer, field: 'city', 'errors')}"><g:textField name="city" value="${contract?.customer?.city}" /></td></tr>
<tr><td><g:message code="customer.country.label" />*:</td><td class="value ${hasErrors(bean: customer, field: 'country', 'errors')}"><g:textField name="country" value="${contract?.customer?.country}" /></td></tr>
<tr><td><g:message code="shiroUser.email.label" />*:</td><td class="value ${hasErrors(bean: shiroUser, field: 'email', 'errors')}"><g:textField name="email" value="${shiroUser.email}" /></td></tr>
<tr><td><g:message code="shiroUser.birthday.label" />:</td><td class="value ${hasErrors(bean: shiroUser, field: 'birthday', 'errors')}"><g:datePicker
precision="day" name="birthday" value="${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].birthday:""}" defaultValue="${new Date()}" /></td>
</tr>
<tr><td><g:message code="customer.tel1.label" />:</td><td class="value ${hasErrors(bean: customer, field: 'tel1', 'errors')}"><g:textField name="tel1" value="${contract?.customer?.tel1}"/></td></tr>
<tr><td><g:message code="shiroUser.telMobile.label" />:</td><td class="value ${hasErrors(bean: shiroUser, field: 'telMobile', 'errors')}"><g:textField name="telMobile" value="${shiroUser.telMobile}"/></td></tr>
<tr><td><g:message code="shiroUser.occupation.label" />:</td><td class="value ${hasErrors(bean: customer, field: 'occupation', 'errors')}"><g:textField name="occupation" value="${shiroUser.occupation}" /></td></tr>
<tr><td><g:message code="customer.url.label" />:</td><td class="value ${hasErrors(bean: customer, field: 'url', 'errors')}"><g:textField name="url" value="${contract?.customer?.url}" /></td></tr>
<tr><td><g:message code="customer.allowPublishNameOnWebsite.label" />:</td><td><g:checkBox name="allowPublishNameOnWebsite" value="${contract?.customer?.allowPublishNameOnWebsite}" /> <g:message code="customer.allowPublishNameOnWebsite_ext.label" /></td></tr>
<tr><td><g:message code="contract.contractStart.label" />:</td><td class="value ${hasErrors(bean: contract, field: 'contractStart', 'errors')}">
        <calendar:datePicker
        dateFormat="%d.%m.%Y"
        name="contractStart"
        defaultValue="${new Date()}"
        value="${contract?.contractStart}"/>
</td>
</tr>
<tr><td><g:message code="contract.quantity.label" />:</td><td class="value ${hasErrors(bean: contract, field: 'quantity', 'errors')}"><g:select name="quantity"
                                                                                                                                          from="${1..100}"
                                                                                                                                          value="${contract?.quantity}"
                                                                                                                                          onChange="loadSubOptions(document.contract.product.value);" /></td></tr>

<tr><td><g:message code="contract.paymentMethod.label" />:</td><td class="value ${hasErrors(bean: contract, field: 'paymentMethod', 'errors')}">
<g:radio name="paymentMethod" value="0" checked="${contract?.paymentMethod==0}"/>&nbsp;<g:message code="contract.paymentMethod.0" /><br>
<g:radio name="paymentMethod" value="1" checked="${contract?.paymentMethod==1}"/>&nbsp;<g:message code="contract.paymentMethod.1" /><br>
<!-- <g:radio name="paymentMethod" value="2" checked="${!contract?.paymentMethod==2}"/>&nbsp;<g:message code="contract.paymentMethod.2" /><br>') -->
</td></tr>
<tr><td><g:message code="contract.autoExtend.label" />:</td><td class="value ${hasErrors(bean: contract, field: 'autoExtend', 'errors')}">
<g:radio name="autoExtend" value="true" checked="${contract?.autoExtend}" onChange="autoExtend(this.value);"/>&nbsp;<g:message code="contract.autoExtend.true" /><br>
<g:radio name="autoExtend" value="false" checked="${!contract?.autoExtend}" onChange="autoExtend(this.value);"/>&nbsp;<g:message code="contract.autoExtend.false" />
</td></tr>
<tr><td  class="value ${hasErrors(bean: customer, field: 'reverseChargeSystem', 'errors')}"><g:message code="customer.reverseChargeSystem.label" />:</td><td><g:checkBox name="reverseChargeSystem" value="${contract?.customer?.reverseChargeSystem}" onChange="loadSubOptions(document.contract.product.value);"/>
&nbsp;<g:message code="customer.reverseChargeSystemID.label" />:&nbsp;<g:textField name="reverseChargeSystemID" value="${contract?.customer?.reverseChargeSystemID}" />&nbsp;
</td></tr>
<tr><td><g:message code="contract.products.label" />:</td><td class="value ${hasErrors(bean: contract, field: 'products', 'errors')}">
<g:select name="product"  from="${le.space.Product.findAll('from Product as p where p.option is null and p.publicProduct=true')}"
                          valueMessagePrefix="contract.product"
                          value="${(contract?.getProducts() && contract?.getProducts()?.size()>0)?(contract.getProducts().toArray().sort{it.id})[0].id:null}"
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
                                        url: document.contract.url.value,
                                        firstname:document.contract.firstname.value,
                                        name:document.contract.name.value,
                                        occupation:document.contract.occupation.value,
                                        company:document.contract.company.value,
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
  <g:render template="optionsOfProduct" />
</div>