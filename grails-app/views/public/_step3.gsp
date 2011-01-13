<p><g:message code="contract.intro3" /></p>
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
  <tr><td><g:message code="shiroUser.salutation.label" />:</td><td class="value" id="salutation">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].salutation:""}</td></tr>
<tr><td><g:message code="shiroUser.firstname.label" />:</td><td class="value" id="firstname">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].firstname:""}</td></tr>
<tr><td><g:message code="shiroUser.lastname.label" />:</td><td class="value" id="lastname">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].lastname:""}</td></tr>
<tr><td><g:message code="customer.addressLine1.label" />:</td><td class="value" id="addressLine1">${contract?.customer?.addressLine1}</td></tr>
<tr><td><g:message code="customer.addressLine2.label" />:</td><td class="value" id="addressLine2">${contract?.customer?.addressLine2}</td></tr>
<tr><td><g:message code="customer.zip.label" />:</td><td class="value" id="zip">${contract?.customer?.zip}</td></tr>
<tr><td><g:message code="customer.city.label" />:</td><td class="value" id="city">${contract?.customer?.city}</td></tr>
<tr><td><g:message code="customer.country.label" />:</td><td class="value" id="country">${contract?.customer?.country}</td></tr>
<tr><td><g:message code="shiroUser.email.label" />:</td><td class="value" id="email">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].email:""}</td></tr>
<tr><td><g:message code="shiroUser.birthday.label" />:</td><td class="value" id="birthday"><g:formatDate format="dd.MM.yyyy" date="${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers?.toArray()[0].email:""}"/></td></tr>
<tr><td><g:message code="customer.tel1.label" />:</td><td class="value" id="tel1">${(contract?.customer?.shiroUsers)?contract?.customer?.tel1:""}</td></tr>
<tr><td><g:message code="shiroUser.telMobile.label" />:</td><td class="value" id="telMobile">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers?.toArray()[0].telMobile:""}</td></tr>
<tr><td><g:message code="customer.company.label" />:</td><td class="value" id="company">${contract?.customer.company}</td></tr>
<tr><td><g:message code="shiroUser.occupation.label" />:</td><td class="value" id="occupation">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers?.toArray()[0].occupation:""}</td></tr>
<tr><td><g:message code="customer.url.label" />:</td><td class="value" id="url">${contract?.customer?.url}</td></tr>
<tr><td><g:message code="customer.allowPublishNameOnWebsite.label" id="allowPublishNameOnWebsite"/>:</td><td>
<g:if test="${allowPublishNameOnWebsite=='on'}"><g:message code="customer.allowPublishNameOnWebsite_ext.label" /></g:if></td></tr>
<tr><td><g:message code="contract.contractStart.label" />:</td><td class="value"><g:formatDate format="dd.MM.yyyy" date="${contract.contractStart}"/></td></tr>

<tr><td><g:message code="contract.products.label" />:</td><td class="value">
<g:each in="${contract.products}">
  <p>${it.name}  (${g.formatNumber(number:it.priceGross,format:'€ ###,##0.00')}/${g.formatNumber(number:it.priceNet,format:'€ ###,##0.00')})</p>
</g:each>
</td></tr>
<tr><td><g:message code="contract.autoExtend.label" />:</td><td class="value">
<g:if test="${contract.autoExtend}"><g:message code="contract.autoExtend.true" /></g:if>
<g:if test="${!contract.autoExtend}"><g:message code="contract.autoExtend.false" /></g:if>
</td></tr>
<g:if test="${!contract.autoExtend}"><tr><td><g:message code="contract.contractEnd.label" />:</td><td class="value"><g:formatDate format="dd.MM.yyyy" date="${contract.contractEnd}"/></td></tr></g:if>
<tr><td><g:message code="contract.paymentMethod.label" />:</td><td class="value">
<g:if test="${contract.paymentMethod==0}"><g:message code="contract.paymentMethod.0" /></g:if>
<g:if test="${contract.paymentMethod==1}"><g:message code="contract.paymentMethod.1" /></g:if>
<g:if test="${contract.paymentMethod==2}"><g:message code="contract.paymentMethod.2" /></g:if>
</td></tr>
<tr><td><g:message code="customer.publication.label" />:</td><td>${contract.customer?.publicationHTML}</td></tr>
</table>
<table><tr><td colspan="2"><g:message code="contract.total.label" />:</td></tr>
<tr><td><g:message code="contract.amountNet.label" />:</td><td id="amountNet" align="right"><g:formatNumber number="${contract.amountNet}" format="€ ###,##0.00" /></td></tr>
<tr><td><g:message code="contract.vat.label" />:</td><td align="right" id="amountVat"><g:formatNumber number="${contract.amountVAT}" format="€ ###,##0.00" /></td></tr>
<tr><td><g:message code="contract.amountGross.label" />:</td><td align="right" id="amountGross"><g:formatNumber number="${contract.amountGross}" format="€ ###,##0.00" /></td></tr>
</table>
<!--https://cms.paypal.com/us/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_html_Appx_websitestandard_htmlvariables -->

<g:form name="contract" controller="public" method="post">
  <g:hiddenField name="id" value="${contract.id}" />
  <g:hiddenField name="_format" value="PDF" />
  <g:hiddenField name="imageUrl" value="${le.space.HelperTools.getServerAndContext(request)}/public/customerLogo/" />
  <g:hiddenField name="_inline" value="false" />
  <g:hiddenField name="_name" value="contract" />
  <g:hiddenField name="_file" value="contract"  />
  <p><input type="checkbox" name="agbs" value="false" onChange="javascript:document.getElementById('register').disabled = !document.getElementById('register').disabled"/>${g.message(code:'contract.agb_read')} <a href="${createLinkTo(dir:'agb')}" target="_blank">AGB's lesen</a></p>
  <g:if test="${contract.paymentMethod==0}">
    <g:submitToRemote update="update" action="step1" controller="public" name="back" value="${g.message(code:'contract.back')}" /></g:if>
  <g:if test="${contract.paymentMethod==1}">
    <g:submitToRemote update="update" action="step2" controller="public" name="back" value="${g.message(code:'contract.back')}" /></g:if>

 <input type="button" value="${g.message(code:'contract.register')}" id="register"  disabled="disabled" name="register" onclick="new Ajax.Updater('update','${createLinkTo(dir:'/public/register')}',{asynchronous:true,evalScripts:true,parameters:Form.serialize(this.form)});return false">
</g:form>
