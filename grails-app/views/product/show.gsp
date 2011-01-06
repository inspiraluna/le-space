
<%@ page import="le.space.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="admin  " />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
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
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.productNo.label" default="Product No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "productNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.priceNet.label" default="Price Net" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "priceNet")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.priceVAT.label" default="Price VAT" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "priceVAT")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.priceGross.label" default="Price Gross" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "priceGross")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.vat.label" default="Vat" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "vat")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.option.label" default="Option" /></td>
                            
                            <td valign="top" class="value"><g:link controller="product" action="show" id="${productInstance?.option?.id}">${productInstance?.option?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.durationType.label" default="Duration Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "durationType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.duration.label" default="Duration" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "duration")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.autoExtendPossible.label" default="Auto Extend Possible" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${productInstance?.autoExtendPossible}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.validFrom.label" default="Valid From" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${productInstance?.validFrom}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.validTo.label" default="Valid To" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${productInstance?.validTo}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.allowedLoginDays.label" default="Allowed Login Days" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "allowedLoginDays")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.publicProduct.label" default="Public Product" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${productInstance?.publicProduct}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${productInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
