
<%@ page import="le.space.Login" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'login.label', default: 'Login')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'login.id.label', default: 'Id')}" />
                        
                            <th><g:message code="login.user.label" default="User" /></th>
                        
                            <g:sortableColumn property="ipAddress" title="${message(code: 'login.ipAddress.label', default: 'Ip Address')}" />
                        
                            <g:sortableColumn property="macAddress" title="${message(code: 'login.macAddress.label', default: 'Mac Address')}" />
                        
                            <g:sortableColumn property="loginStart" title="${message(code: 'login.loginStart.label', default: 'Login Start')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${loginInstanceList}" status="i" var="loginInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${loginInstance.id}">${fieldValue(bean: loginInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: loginInstance, field: "user")}</td>
                        
                            <td>${fieldValue(bean: loginInstance, field: "ipAddress")}</td>
                        
                            <td>${fieldValue(bean: loginInstance, field: "macAddress")}</td>
                        
                            <td><g:formatDate date="${loginInstance.loginStart}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${loginInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
