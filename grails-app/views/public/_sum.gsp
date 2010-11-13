<table><tr><td colspan="2"><g:message code="contract.total.label" />:</td></tr>
<tr><td><g:message code="contract.amountNet.label" />:</td><td align="right" id="amountNet"><g:formatNumber number="${session.contract?.amountNet}" format="€ ###,##0.00" /></td></tr>
<tr><td><g:message code="contract.vat.label" />:</td><td align="right" id="amountVat"><g:formatNumber number="${session.contract?.amountVAT}" format="€ ###,##0.00" /></td></tr>
<tr><td><g:message code="contract.amountGross.label" />:</td><td align="right" id="amountGross"><g:formatNumber number="${session.contract?.amountGross}" format="€ ###,##0.00" /></td></tr>
<tr><td colspan="2"><g:submitToRemote update="update" action="step2" controller="public" name="forward" value="${g.message(code:'contract.forward')}" /></td></tr>
</table>