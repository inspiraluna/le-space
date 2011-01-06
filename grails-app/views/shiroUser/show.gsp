
<%@ page import="le.space.ShiroUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
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
                            <td valign="top" class="name"><g:message code="shiroUser.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.username.label" default="Username" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "username")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.passwordHash.label" default="Password Hash" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "passwordHash")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.salutation.label" default="Salutation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "salutation")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.firstname.label" default="Firstname" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "firstname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.lastname.label" default="Lastname" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "lastname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.birthday.label" default="Birthday" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${shiroUserInstance?.birthday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.telMobile.label" default="Tel Mobile" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "telMobile")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.occupation.label" default="Occupation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "occupation")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.twitterName.label" default="Twitter Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "twitterName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.facebookName.label" default="Facebook Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "facebookName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.optOutIamHereFunction.label" default="Opt Out Iam Here Function" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${shiroUserInstance?.optOutIamHereFunction}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${shiroUserInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.dateModified.label" default="Date Modified" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${shiroUserInstance?.dateModified}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="shiroUser" action="show" id="${shiroUserInstance?.createdBy?.id}">${shiroUserInstance?.createdBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.modifiedBy.label" default="Modified By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="shiroUser" action="show" id="${shiroUserInstance?.modifiedBy?.id}">${shiroUserInstance?.modifiedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.logins.label" default="Logins" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${shiroUserInstance.logins}" var="l">
                                    <li><g:link controller="login" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.permissions.label" default="Permissions" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: shiroUserInstance, field: "permissions")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="shiroUser.roles.label" default="Roles" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${shiroUserInstance.roles}" var="r">
                                    <li><g:link controller="shiroRole" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${shiroUserInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
