

<%@ page import="le.space.ShiroUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
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
            <g:hasErrors bean="${shiroUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${shiroUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="shiroUser.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'username', 'errors')}">
                                    <input type="text" id="username" name="username" value="${fieldValue(bean:shiroUserInstance,field:'username')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwordHash"><g:message code="shiroUser.passwordHash.label" default="Password Hash" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'passwordHash', 'errors')}">
                                    <input type="text" id="passwordHash" name="passwordHash" value="${fieldValue(bean:shiroUserInstance,field:'passwordHash')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="salutation"><g:message code="shiroUser.salutation.label" default="Salutation" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'salutation', 'errors')}">
                                    <input type="text" id="salutation" name="salutation" value="${fieldValue(bean:shiroUserInstance,field:'salutation')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstname"><g:message code="shiroUser.firstname.label" default="Firstname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'firstname', 'errors')}">
                                    <input type="text" id="firstname" name="firstname" value="${fieldValue(bean:shiroUserInstance,field:'firstname')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastname"><g:message code="shiroUser.lastname.label" default="Lastname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'lastname', 'errors')}">
                                    <input type="text" id="lastname" name="lastname" value="${fieldValue(bean:shiroUserInstance,field:'lastname')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="shiroUser.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'email', 'errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:shiroUserInstance,field:'email')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="birthday"><g:message code="shiroUser.birthday.label" default="Birthday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'birthday', 'errors')}">
                                    <g:datePicker name="birthday" value="${shiroUserInstance?.birthday}" noSelection="['':'']"></g:datePicker>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telMobile"><g:message code="shiroUser.telMobile.label" default="Tel Mobile" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'telMobile', 'errors')}">
                                    <input type="text" id="telMobile" name="telMobile" value="${fieldValue(bean:shiroUserInstance,field:'telMobile')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="occupation"><g:message code="shiroUser.occupation.label" default="Occupation" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'occupation', 'errors')}">
                                    <input type="text" id="occupation" name="occupation" value="${fieldValue(bean:shiroUserInstance,field:'occupation')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="twitterName"><g:message code="shiroUser.twitterName.label" default="Twitter Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'twitterName', 'errors')}">
                                    <input type="text" id="twitterName" name="twitterName" value="${fieldValue(bean:shiroUserInstance,field:'twitterName')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="facebookName"><g:message code="shiroUser.facebookName.label" default="Facebook Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'facebookName', 'errors')}">
                                    <input type="text" id="facebookName" name="facebookName" value="${fieldValue(bean:shiroUserInstance,field:'facebookName')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="optOutIamHereFunction"><g:message code="shiroUser.optOutIamHereFunction.label" default="Opt Out Iam Here Function" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'optOutIamHereFunction', 'errors')}">
                                    <g:checkBox name="optOutIamHereFunction" value="${shiroUserInstance?.optOutIamHereFunction}" ></g:checkBox>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateModified"><g:message code="shiroUser.dateModified.label" default="Date Modified" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'dateModified', 'errors')}">
                                    <g:datePicker name="dateModified" value="${shiroUserInstance?.dateModified}" noSelection="['':'']"></g:datePicker>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdBy"><g:message code="shiroUser.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'createdBy', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.ShiroUser.list()}" name="createdBy.id" value="${shiroUserInstance?.createdBy?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="modifiedBy"><g:message code="shiroUser.modifiedBy.label" default="Modified By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: shiroUserInstance, field: 'modifiedBy', 'errors')}">
                                    <g:select optionKey="id" from="${le.space.ShiroUser.list()}" name="modifiedBy.id" value="${shiroUserInstance?.modifiedBy?.id}" noSelection="['null':'']"></g:select>
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
