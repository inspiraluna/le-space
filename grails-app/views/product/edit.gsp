

<%@ page import="le.space.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
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
            <g:hasErrors bean="${productInstance}">
            <div class="errors">
                <g:renderErrors bean="${productInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${productInstance?.id}" />
                <g:hiddenField name="version" value="${productInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="productNo"><g:message code="product.productNo.label" default="Product No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'productNo', 'errors')}">
                                    <input type="text" id="productNo" name="productNo" value="${fieldValue(bean:productInstance,field:'productNo')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="product.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'name', 'errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:productInstance,field:'name')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="product.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'description', 'errors')}">
                                    <input type="text" id="description" name="description" value="${fieldValue(bean:productInstance,field:'description')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="priceNet"><g:message code="product.priceNet.label" default="Price Net" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'priceNet', 'errors')}">
                                    <input type="text" id="priceNet" name="priceNet" value="${fieldValue(bean:productInstance,field:'priceNet')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="priceVAT"><g:message code="product.priceVAT.label" default="Price VAT" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'priceVAT', 'errors')}">
                                    <input type="text" id="priceVAT" name="priceVAT" value="${fieldValue(bean:productInstance,field:'priceVAT')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="priceGross"><g:message code="product.priceGross.label" default="Price Gross" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'priceGross', 'errors')}">
                                    <input type="text" id="priceGross" name="priceGross" value="${fieldValue(bean:productInstance,field:'priceGross')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vat"><g:message code="product.vat.label" default="Vat" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'vat', 'errors')}">
                                    <input type="text" id="vat" name="vat" value="${fieldValue(bean:productInstance,field:'vat')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="option"><g:message code="product.option.label" default="Option" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'option', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.Product.list()}" name="option.id" value="${productInstance?.option?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="durationType"><g:message code="product.durationType.label" default="Duration Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'durationType', 'errors')}">
                                    <input type="text" id="durationType" name="durationType" value="${fieldValue(bean:productInstance,field:'durationType')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="duration"><g:message code="product.duration.label" default="Duration" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'duration', 'errors')}">
                                    <input type="text" id="duration" name="duration" value="${fieldValue(bean:productInstance,field:'duration')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="autoExtendPossible"><g:message code="product.autoExtendPossible.label" default="Auto Extend Possible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'autoExtendPossible', 'errors')}">
                                    <g:checkBox name="autoExtendPossible" value="${productInstance?.autoExtendPossible}" ></g:checkBox>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="validFrom"><g:message code="product.validFrom.label" default="Valid From" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'validFrom', 'errors')}">
                                    <g:datePicker name="validFrom" value="${productInstance?.validFrom}" ></g:datePicker>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="validTo"><g:message code="product.validTo.label" default="Valid To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'validTo', 'errors')}">
                                    <g:datePicker name="validTo" value="${productInstance?.validTo}" noSelection="['':'']"></g:datePicker>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="allowedLoginDays"><g:message code="product.allowedLoginDays.label" default="Allowed Login Days" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'allowedLoginDays', 'errors')}">
                                    <input type="text" id="allowedLoginDays" name="allowedLoginDays" value="${fieldValue(bean:productInstance,field:'allowedLoginDays')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="publicProduct"><g:message code="product.publicProduct.label" default="Public Product" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'publicProduct', 'errors')}">
                                    <g:checkBox name="publicProduct" value="${productInstance?.publicProduct}" ></g:checkBox>
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
