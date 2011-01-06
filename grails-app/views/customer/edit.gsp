

<%@ page import="le.space.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="admin" />
        <g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
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
            <g:hasErrors bean="${customerInstance}">
            <div class="errors">
                <g:renderErrors bean="${customerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${customerInstance?.id}" />
                <g:hiddenField name="version" value="${customerInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="company"><g:message code="customer.company.label" default="Company" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'company', 'errors')}">
                                    <input type="text" id="company" name="company" value="${fieldValue(bean:customerInstance,field:'company')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="addressLine1"><g:message code="customer.addressLine1.label" default="Address Line1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'addressLine1', 'errors')}">
                                    <input type="text" id="addressLine1" name="addressLine1" value="${fieldValue(bean:customerInstance,field:'addressLine1')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="addressLine2"><g:message code="customer.addressLine2.label" default="Address Line2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'addressLine2', 'errors')}">
                                    <input type="text" id="addressLine2" name="addressLine2" value="${fieldValue(bean:customerInstance,field:'addressLine2')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="zip"><g:message code="customer.zip.label" default="Zip" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'zip', 'errors')}">
                                    <input type="text" id="zip" name="zip" value="${fieldValue(bean:customerInstance,field:'zip')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="city"><g:message code="customer.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'city', 'errors')}">
                                    <input type="text" id="city" name="city" value="${fieldValue(bean:customerInstance,field:'city')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="country"><g:message code="customer.country.label" default="Country" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'country', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.Country.list()}" name="country.id" value="${customerInstance?.country?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tel1"><g:message code="customer.tel1.label" default="Tel1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'tel1', 'errors')}">
                                    <input type="text" id="tel1" name="tel1" value="${fieldValue(bean:customerInstance,field:'tel1')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fax"><g:message code="customer.fax.label" default="Fax" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'fax', 'errors')}">
                                    <input type="text" id="fax" name="fax" value="${fieldValue(bean:customerInstance,field:'fax')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="url"><g:message code="customer.url.label" default="Url" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'url', 'errors')}">
                                    <input type="text" id="url" name="url" value="${fieldValue(bean:customerInstance,field:'url')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="allowPublishNameOnWebsite"><g:message code="customer.allowPublishNameOnWebsite.label" default="Allow Publish Name On Website" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'allowPublishNameOnWebsite', 'errors')}">
                                    <g:checkBox name="allowPublishNameOnWebsite" value="${customerInstance?.allowPublishNameOnWebsite}" ></g:checkBox>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bankAccount"><g:message code="customer.bankAccount.label" default="Bank Account" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'bankAccount', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.BankAccount.list()}" name="bankAccount.id" value="${customerInstance?.bankAccount?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reverseChargeSystem"><g:message code="customer.reverseChargeSystem.label" default="Reverse Charge System" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'reverseChargeSystem', 'errors')}">
                                    <g:checkBox name="reverseChargeSystem" value="${customerInstance?.reverseChargeSystem}" ></g:checkBox>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reverseChargeSystemID"><g:message code="customer.reverseChargeSystemID.label" default="Reverse Charge System ID" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'reverseChargeSystemID', 'errors')}">
                                    <input type="text" id="reverseChargeSystemID" name="reverseChargeSystemID" value="${fieldValue(bean:customerInstance,field:'reverseChargeSystemID')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateModified"><g:message code="customer.dateModified.label" default="Date Modified" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'dateModified', 'errors')}">
                                    <g:datePicker name="dateModified" value="${customerInstance?.dateModified}" noSelection="['':'']"></g:datePicker>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="createdBy"><g:message code="customer.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'createdBy', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.ShiroUser.list()}" name="createdBy.id" value="${customerInstance?.createdBy?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="modifiedBy"><g:message code="customer.modifiedBy.label" default="Modified By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'modifiedBy', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.ShiroUser.list()}" name="modifiedBy.id" value="${customerInstance?.modifiedBy?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contracts"><g:message code="customer.contracts.label" default="Contracts" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'contracts', 'errors')}">
                                    
<ul>
<g:each var="c" in="${customerInstance?.contracts?}">
    <li><g:link controller="contract" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="contract" params="['customer.id':customerInstance?.id]" action="create">Add Contract</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="payments"><g:message code="customer.payments.label" default="Payments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'payments', 'errors')}">
                                    
<ul>
<g:each var="p" in="${customerInstance?.payments?}">
    <li><g:link controller="payment" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="payment" params="['customer.id':customerInstance?.id]" action="create">Add Payment</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="shiroUsers"><g:message code="customer.shiroUsers.label" default="Shiro Users" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'shiroUsers', 'errors')}">
                                    <g:select name="shiroUsers"
from="${le.space.ShiroUser.list()}"
size="5" multiple="yes" optionKey="id"
value="${customerInstance?.shiroUsers}" />

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
