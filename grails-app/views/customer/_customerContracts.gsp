<table>
  <thead>
    <tr>
  <g:sortableColumn align="left" valign="top" property="id" title="${message(code: 'contract.id.label', default: 'Id')}" />
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
<g:each in="${contractList}" status="i" var="contractInstance">
  <tr class="${(contractInstance.paid)?((i % 2) == 0 ? 'odd' : 'even'):'red'}">
    <td valign="top">
  <g:if test="${numbers}"><g:link action="show" id="${contractInstance.id}">${fieldValue(bean: contractInstance, field: "id")}</g:link></g:if>
  <g:if test="${!numbers}">${fieldValue(bean: contractInstance, field: "id")}</g:if>
  </td>
  <td valign="top" ><g:formatDate date="${contractInstance.contractStart}" format="dd.MM.yyyy"/></td>
  <td valign="top">
  <g:if test="${(!contractInstance.autoExtend)}">
    <g:formatDate date="${contractInstance.contractEnd}" format="dd.MM.yyyy"/>
  </g:if>
  <g:if test="${(contractInstance.autoExtend)}">
${message(code: 'contract.autoExtend.true', default: 'autoExtend')}
  </g:if>
  </td>

  <td valign="top" nowrap><g:formatNumber number="${contractInstance.customer.amountTotal}" format="€ ###,##0.00" />/
  <g:formatNumber number="${contractInstance.customer.amountPaid}" format="€ ###,##0.00" />/
  <g:formatNumber number="${contractInstance.customer.amountDue}" format="€ ###,##0.00" /></td>
  <td valign="top" >${fieldValue(bean: contractInstance, field: "valid")}</td>
  <td valign="top" align="right" nowrap><g:formatNumber number="${contractInstance.amountGross}" format="€ ###,##0.00" /></td>
  <td valign="top" align="left">${fieldValue(bean: contractInstance, field: "quantity")} x <ul><g:each in="${contractInstance.getProducts()}" status="j" var="p">
        <li>${p.name}</g:each>
    </ul></td>
  <td valign="top" align="right">${fieldValue(bean: contractInstance, field: "loginDays")} / ${fieldValue(bean: contractInstance, field: "allowedLoginDaysLeft")}</td>
  <td valign="top" align="left" nowrap><g:formatDate date="${contractInstance.lastLogin}" format="dd.MM.yyyy HH:mm:ss"/></td>
  <td valign="top" align="left">
  <g:form controller="public">
    <div class="buttons">
      <g:hiddenField name="id" value="${contractInstance?.id}" />
      <g:hiddenField name="_format" value="PDF" />
      <g:hiddenField name="_inline" value="false" />
      <g:hiddenField name="_name" value="contract_${contractInstance?.id}_${contractInstance?.customer?.company?.replace(' ','_')}" />
      <g:hiddenField name="_file" value="contract"  />
      <span class="button"><g:actionSubmit action="contractPdf"  value="${g.message(code:'contract.print')}" /></span>
    </div>
  </g:form>
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