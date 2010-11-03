<%@ page import="le.space.Contract" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="admin" />
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
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
    <g:form name="list" action="list">
      <table id="searchTasks" width="890">
        <tr>
          <td align="left" valign="middle"><g:message code="contract.searchText" />:</td>
        <td align="left" valign="middle"><g:textField name="searchText" value="${searchText}"/>
        </td>
        <td><g:message code="contract.valid" /><g:select name="valid" from="${['all','true', 'false']}" value="${valid}" onchange="document.list.submit();"/>+</td>
        <td><g:message code="contract.paid" /><g:select name="paid" from="${['all','true', 'false']}" value="${paid}" onchange="document.list.submit();"/></td>
        <td><div class="buttons">
            <span class="button">
              <g:actionSubmit class="input search" value="${g.message(code:'contract.search')}" action="list" />
            </span></div>
        </td>
        </tr>
      </table>
    </g:form>
    <div class="list">
      <table>
        <thead>
          <tr>
        <g:sortableColumn align="left" valign="top" property="id" title="${message(code: 'contract.id.label', default: 'Id')}" />
        <g:sortableColumn align="left" valign="top" property="contract.customer.shiroUsers.toArray()[0].salutation" title="${message(code: 'contract.salutation.label', default: 'Salutation')}" />
        <g:sortableColumn align="left" valign="top" property="firstname" title="${message(code: 'contract.firstname.label', default: 'Firstname')}" />
        <g:sortableColumn align="left" valign="top" property="lastname" title="${message(code: 'contract.lastname.label', default: 'Lastname')}" />
        <g:sortableColumn align="left" valign="top" property="city" title="${message(code: 'contract.city.label', default: 'City')}" />
        <g:sortableColumn align="left" valign="top" property="email" title="${message(code: 'contract.email.label', default: 'Email')}" />
        <g:sortableColumn align="left" valign="top" property="allowPublishNameOnWebsite" title="${message(code: 'contract.allowPublishNameOnWebsite.label', default: 'WWW')}" />
        <g:sortableColumn align="left" valign="top" property="telMobile" title="${message(code: 'contract.telMobile.label', default: 'Mobile')}" />
        <g:sortableColumn align="left" valign="top" property="contractStart" title="${message(code: 'contract.contractStart.label', default: 'Contract Start')}" />
        <g:sortableColumn align="left" valign="top" property="contractEnd" title="${message(code: 'contract.contractEnd.label', default: 'Contract End')}" />
        <g:sortableColumn align="left" valign="top" property="autoExtend" title="${message(code: 'contract.autoExtend.label', default: 'autoextend')}" />
        <g:sortableColumn align="left" valign="top" property="paid" title="${message(code: 'contract.paid.label', default: 'paid')}" />
        <g:sortableColumn align="left" valign="top" property="valid" title="${message(code: 'contract.valid.label', default: 'valid')}" />
        <g:sortableColumn align="left" valign="top" property="amountGross" title="${message(code: 'contract.amountGross.label', default: 'amountGross')}" />
        <g:sortableColumn align="left" valign="top" property="selectedProducts" title="${message(code: 'contract.selectedProducts.label', default: 'Selected Products')}" />
        <g:sortableColumn align="left" valign="top" property="allowedLoginDaysLeft" title="${message(code: 'contract.allowedLoginDaysLeft', default: 'Logins left')}" />
        <g:sortableColumn align="left" valign="top" property="loginDays" title="${message(code: 'contract.loginDays', default: 'number of logins')}" />
        <g:sortableColumn align="left" valign="top" property="lastLogin" title="${message(code: 'contract.lastLogin', default: 'lastLogin')}" />
        <td>Login!</td>
        </tr>
        </thead>
        <tbody>
        <g:each in="${contractInstanceList}" status="i" var="contractInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td valign="top" ><g:link action="show" id="${contractInstance.id}">${fieldValue(bean: contractInstance, field: "id")}</g:link></td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "customer?.shiroUsers.toArray()[0].salutation")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "firstname")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "lastname")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "city")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "email")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "allowPublishNameOnWebsite")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "telMobile")}</td>
          <td valign="top" ><g:formatDate date="${contractInstance.contractStart}" format="dd.MM.yyyy"/></td>
          <td valign="top" ><g:formatDate date="${contractInstance.contractEnd}" format="dd.MM.yyyy"/></td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "autoExtend")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "paid")}</td>
          <td valign="top" >${fieldValue(bean: contractInstance, field: "valid")}</td>
          <td valign="top" align="right"><g:formatNumber number="${contractInstance.amountGross}" format="€ ###,##0.00" /></td>
          <td valign="top" align="left">${fieldValue(bean: contractInstance, field: "selectedProducts")}</td>
          <td valign="top" align="right">${fieldValue(bean: contractInstance, field: "allowedLoginDaysLeft")}</td>
          <td valign="top" align="right">${fieldValue(bean: contractInstance, field: "loginDays")}</td>
          <td valign="top" align="left"><g:formatDate date="${contractInstance.lastLogin}" format="dd.MM.yyyy hh:mm:ss"/></td>
          <td valign="top" align="left">
            <%//contractInstance?.valid &&%>
          <g:if test="${contractInstance?.lastLogin?.getTime()<=(new org.joda.time.DateTime().withTime(0,0,0,0).toDate().getTime())}">
            <g:form name="login" action="addLogin"><g:hiddenField name="id" value="${contractInstance?.id}" />
                <g:actionSubmit class="input login" value="${g.message(code:'contract.login')}" action="addLogin" /></g:form>
          </g:if>
          </td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate  max="${max}" offset="${offset}" total="${totalCount}" />
      <export:formats formats="['csv', 'excel', 'ods', 'pdf', 'rtf', 'xml']" />
    </div>
  </div>
</body>
</html>
