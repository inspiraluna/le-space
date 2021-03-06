<%@ page import="le.space.Contract" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="admin" />
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
  <div id="koerper">
    <div id="inhalt">
      <h1><g:message code="default.list.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:form name="list" action="list">
        <table id="searchTasks">
          <tr>
            <td align="left" valign="middle" nowrap><g:message code="contract.searchText" />:</td>
          <td align="left" valign="middle" nowrap><g:textField name="searchText" value="${searchText}"/>
          </td>
          <td nowrap><g:message code="contract.contractStart.label" />:<calendar:datePicker dateFormat="%d.%m.%Y" name="dateFrom" value="${dateFrom}" defaultValue="${null}" years="2009,2999"/>
          </td>
          <td nowrap><g:message code="contract.contractEnd.label" />:<calendar:datePicker dateFormat="%d.%m.%Y" name="dateTo" value="${dateTo}" defaultValue="${null}" years="2009,2999"/>
          </td>
          </tr>
          <tr>
          <td nowrap><g:message code="contract.loggedIn" /><g:checkBox name="loggedInOnly" value="true" checked="${loggedInOnly}" onchange="document.list.submit();"/><g:message code="contract.valid" /><g:select name="valid" from="${['all','true', 'false']}" value="${valid}" onchange="document.list.submit();"/></td>
          <td nowrap><g:message code="contract.paid" /><g:select name="paid" from="${['all','true', 'false']}" value="${paid}" onchange="document.list.submit();"/></td>
          <td nowrap><g:message code="contract.withProducts" />
              <g:select name="searchProducts"
                        from="${le.space.Product.list()}"
                        noSelection="${['null':'Select One...']}"
                          optionKey="id"
                        value="${searchProducts}" onchange="document.list.submit();"/>
              </td>
                    <td nowrap>
${g.message(code:'default.display.max')} <g:select name="max" from="${['5', '10', '20','50']}" value="${max}" onchange="document.list.submit();"/>
          </td>
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
          <th>${message(code: 'contract.company.label', default: 'Customer')} ${message(code: 'contract.first.label', default: 'Firstname')}
${message(code: 'contract.lastname.label', default: 'Lastname')} ${message(code: 'contract.email.label', default: 'Email')}</th>
          <g:sortableColumn align="left" valign="top" property="contractStart" title="${message(code: 'contract.contractStart.label', default: 'Contract Start')}" />
          <g:sortableColumn align="left" valign="top" property="contractEnd" title="${message(code: 'contract.contractEnd.label', default: 'Contract End')}" />
          <th>${message(code: 'contract.amountTotal.label', default: 'amountTotal')}/${message(code: 'contract.amountPaid.label', default: 'amountPaid')}/${message(code: 'contract.amountDue.label', default: 'amountDue')}</th>
          <g:sortableColumn align="left" valign="top" property="valid" title="${message(code: 'contract.valid.label', default: 'valid')}" />
          <g:sortableColumn align="left" valign="top" property="amountGross" title="${message(code: 'contract.amountGross.label', default: 'amountGross')}" />
          <g:sortableColumn align="left" valign="top" property="selectedProducts" title="${message(code: 'contract.selectedProducts.label', default: 'Selected Products')}" />

          <th>${message(code: 'contract.loginDays', default: 'logins')}/${message(code: 'contract.loginDaysleft', default: 'left')}/${message(code: 'contract.loginDaysGesamt.label', default: 'left')}
          </th>
          <g:sortableColumn align="left" valign="top" property="lastLogin" title="${message(code: 'contract.lastLogin', default: 'lastLogin')}" />
          <th>Login!</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${contractInstanceList}" status="i" var="contractInstance">
            <tr class="${(contractInstance.paid)?((i % 2) == 0 ? 'odd' : 'even'):'red'}">
              <td valign="top"><g:link action="show" id="${contractInstance.id}">${fieldValue(bean: contractInstance, field: "id")}</g:link></td>
            <td valign="top" >(${fieldValue(bean: contractInstance, field: "customer.id")}) ${fieldValue(bean: contractInstance, field: "customer.company")}<br/>
${fieldValue(bean: contractInstance, field: "customer.firstname")}
${fieldValue(bean: contractInstance, field: "customer.lastname")}
              (${fieldValue(bean: contractInstance, field: "customer.email")})</td>
            <td valign="top" ><g:formatDate date="${contractInstance.contractStart}" format="dd.MM.yyyy"/></td>
            <td valign="top">
            <g:if test="${(!contractInstance.autoExtend)}">
              <g:formatDate date="${contractInstance.contractEnd}" format="dd.MM.yyyy"/>
            </g:if>
            <g:else>
${message(code: 'contract.autoExtend.true', default: 'autoExtend')}
            </g:else>
            </td>

            <td valign="top" nowrap><g:formatNumber number="${contractInstance.customer.amountTotal}" format="€ ###,##0.00" />/
            <g:formatNumber number="${contractInstance.customer.amountPaid}" format="€ ###,##0.00" />/
            <g:formatNumber number="${contractInstance.customer.amountDue}" format="€ ###,##0.00" /></td>
            <td valign="top" >${fieldValue(bean: contractInstance, field: "valid")}</td>
            <td valign="top" align="right" nowrap><g:formatNumber number="${contractInstance.amountGross}" format="€ ###,##0.00" /></td>
            <td valign="top" align="left">${fieldValue(bean: contractInstance, field: "quantity")} x <ul><g:each in="${contractInstance?.getProducts()}" status="j" var="p">
                  <li>${p.name}</li>
                </g:each>
      </ul></td>
            <td valign="top" align="right">${fieldValue(bean: contractInstance, field: "loginDays")} / ${fieldValue(bean: contractInstance, field: "allowedLoginDaysLeft")}</td>
            <td valign="top" align="left" nowrap><g:formatDate date="${contractInstance.lastLogin}" format="dd.MM.yyyy HH:mm:ss"/></td>
            <td valign="top" align="left">     
            <g:each in="${contractInstance?.customer?.shiroUsers}" var="user">
              <g:if test="${(!user?.getLogins()) || (user?.getLogins()?.toArray().sort{it.loginStart})[user?.getLogins().size()-1].loginStart?.getTime()<=(new org.joda.time.DateTime().withTime(0,0,0,0).toDate().getTime())}">
                <g:form name="login" action="addLogin">
                  <g:hiddenField name="id" value="${contractInstance?.id}" />
                  <g:hiddenField name="userId" value="${user?.id}" />
                  <g:actionSubmit class="input login" value="${user?.username} ${g.message(code:'contract.login')}" action="addLogin" />
                </g:form>
              </g:if>
            </g:each>
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
  </div>

</body>
</html>
