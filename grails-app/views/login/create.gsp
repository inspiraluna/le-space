

<%@ page import="le.space.Login" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'login.label', default: 'Login')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loginInstance}">
            <div class="errors">
                <g:renderErrors bean="${loginInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="login.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'user', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.ShiroUser.list()}" name="user.id" value="${loginInstance?.user?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ipAddress"><g:message code="login.ipAddress.label" default="Ip Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'ipAddress', 'errors')}">
                                    <input type="text" id="ipAddress" name="ipAddress" value="${fieldValue(bean:loginInstance,field:'ipAddress')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="macAddress"><g:message code="login.macAddress.label" default="Mac Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'macAddress', 'errors')}">
                                    <input type="text" id="macAddress" name="macAddress" value="${fieldValue(bean:loginInstance,field:'macAddress')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loginStart"><g:message code="login.loginStart.label" default="Login Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'loginStart', 'errors')}">
                                    <g:datePicker name="loginStart" value="${loginInstance?.loginStart}" ></g:datePicker>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
