<table>
  <thead>
    <tr>
  <g:sortableColumn align="left" valign="top" property="id" title="${message(code: 'contract.id.label', default: 'Id')}" />
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
  <td></td>
</tr>
</thead>
<tbody>
<g:each in="${contractList}" status="i" var="contractInstance">
  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    <td valign="top">${fieldValue(bean: contractInstance, field: "id")}</td>
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
  <td valign="top" align="left"> <g:form controller="public">
      <div class="buttons">
        <g:hiddenField name="id" value="${contractInstance?.id}" />
        <g:hiddenField name="_format" value="PDF" />
        <g:hiddenField name="_inline" value="false" />
        <g:hiddenField name="_name" value="contract_${contractInstance?.id}_${contractInstance?.customer?.company?.replace(' ','_')}" />
        <g:hiddenField name="_file" value="contract"  />
        <span class="button"><g:actionSubmit action="contractPdf"  value="${g.message(code:'contract.print')}" /></span>
      </div>
    </g:form></td>
  </tr>
</g:each>
</tbody>
</table>
