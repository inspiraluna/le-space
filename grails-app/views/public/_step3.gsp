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
  <tr><td><g:message code="contract.salutation" />:</td><td class="value" id="salutation">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].salutation:""}</td></tr>
<tr><td><g:message code="contract.firstname" />:</td><td class="value" id="firstname">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].firstname:""}</td></tr>
<tr><td><g:message code="contract.lastname" />:</td><td class="value" id="lastname">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].lastname:""}</td></tr>
<tr><td><g:message code="contract.addressLine1" />:</td><td class="value" id="addressLine1">${contract?.customer?.addressLine1}</td></tr>
<tr><td><g:message code="contract.addressLine2" />:</td><td class="value" id="addressLine2">${contract?.customer?.addressLine2}</td></tr>
<tr><td><g:message code="contract.zip" />:</td><td class="value" id="zip">${contract?.customer?.zip}</td></tr>
<tr><td><g:message code="contract.city" />:</td><td class="value" id="city">${contract?.customer?.city}</td></tr>
<tr><td><g:message code="contract.country" />:</td><td class="value" id="country">${contract?.customer?.country}</td></tr>
<tr><td><g:message code="contract.email" />:</td><td class="value" id="email">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers.toArray()[0].email:""}</td></tr>
<tr><td><g:message code="contract.birthday" />:</td><td class="value" id="birthday"><g:formatDate format="dd.MM.yyyy" date="${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers?.toArray()[0].email:""}"/></td></tr>
<tr><td><g:message code="contract.tel1" />:</td><td class="value" id="tel1">${(contract?.customer?.shiroUsers)?contract?.customer?.tel1:""}</td></tr>
<tr><td><g:message code="contract.telMobile" />:</td><td class="value" id="telMobile">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers?.toArray()[0].telMobile:""}</td></tr>
<tr><td><g:message code="contract.company" />:</td><td class="value" id="company">${contract?.customer.company}</td></tr>
<tr><td><g:message code="contract.occupation" />:</td><td class="value" id="occupation">${(contract?.customer?.shiroUsers)?contract?.customer?.shiroUsers?.toArray()[0].occupation:""}</td></tr>
<tr><td><g:message code="contract.url" />:</td><td class="value" id="url">${contract?.customer?.url}</td></tr>
<tr><td><g:message code="contract.allowPublishNameOnWebsite" id="allowPublishNameOnWebsite"/>:</td><td>
<g:if test="${allowPublishNameOnWebsite=='on'}"><g:message code="contract.allowPublishNameOnWebsite_ext" /></g:if></td></tr>
<tr><td><g:message code="contract.contractStart" />:</td><td class="value"><g:formatDate format="dd.MM.yyyy" date="${contract.contractStart}"/></td></tr>

<tr><td><g:message code="contract.products" />:</td><td class="value">
<g:each in="${contract.products}">
  <p>${g.message(code:'contract.product.'+it.id)}  (${g.formatNumber(number:it.priceGross,format:'€ ###,##0.00')}/${g.formatNumber(number:it.priceNet,format:'€ ###,##0.00')})</p>
</g:each>
</td></tr>
<tr><td><g:message code="contract.autoExtend" />:</td><td class="value">
<g:if test="${contract.autoExtend}"><g:message code="contract.autoExtend.true" /></g:if>
<g:if test="${!contract.autoExtend}"><g:message code="contract.autoExtend.false" /></g:if>
</td></tr>
<g:if test="${!contract.autoExtend}"><tr><td><g:message code="contract.contractEnd" />:</td><td class="value"><g:formatDate format="dd.MM.yyyy" date="${contract.contractEnd}"/></td></tr></g:if>
<tr><td><g:message code="contract.paymentMethod" />:</td><td class="value">
<g:if test="${contract.paymentMethod==0}"><g:message code="contract.paymentMethod.0" /></g:if>
<g:if test="${contract.paymentMethod==1}"><g:message code="contract.paymentMethod.1" /></g:if>
<g:if test="${contract.paymentMethod==2}"><g:message code="contract.paymentMethod.2" /></g:if>
</td></tr>
<tr><td><g:message code="contract.publication" />:</td><td>${contract.customer?.publicationHTML}</td></tr>
</table>
<table><tr><td colspan="2"><g:message code="contract.total" />:</td></tr>
<tr><td><g:message code="contract.amountNet" />:</td><td id="amountNet" align="right"><g:formatNumber number="${contract.amountNet}" format="€ ###,##0.00" /></td></tr>
<tr><td><g:message code="contract.vat" />:</td><td align="right" id="amountVat"><g:formatNumber number="${contract.amountVAT}" format="€ ###,##0.00" /></td></tr>
<tr><td><g:message code="contract.amountGross" />:</td><td align="right" id="amountGross"><g:formatNumber number="${contract.amountGross}" format="€ ###,##0.00" /></td></tr>
</table>
<!--https://cms.paypal.com/us/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_html_Appx_websitestandard_htmlvariables -->
<g:form name="contract" controller="public" method="post">
  <g:hiddenField name="id" value="${contract.id}" />
  <g:hiddenField name="_format" value="PDF" />
  <g:hiddenField name="imageUrl" value="${le.space.HelperTools.getServerAndContext(request)}/public/customerLogo/" />
  <g:hiddenField name="_inline" value="false" />
  <g:hiddenField name="_name" value="contract" />
  <g:hiddenField name="_file" value="contract"  />

  <g:submitToRemote update="update" action="step1" controller="public" name="back" value="${g.message(code:'contract.back')}" />
  <g:submitToRemote update="update" action="register" controller="public" name="register" value="${g.message(code:'contract.register')}" />
</g:form>
