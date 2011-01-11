<table><tr><th colspan="2"><g:message code="contract.total.label" />:</th></tr>
<tr><th><g:message code="contract.amountNet.label" />:</th><td align="right" id="amountNet"><g:formatNumber number="${session.contract?.amountNet}" format="€ ###,##0.00" /></td></tr>
<tr><th><g:message code="contract.vat.label" />:</th><td align="right" id="amountVat"><g:formatNumber number="${session.contract?.amountVAT}" format="€ ###,##0.00" /></td></tr>
<tr><th><g:message code="contract.amountGross.label" />:</th><td align="right" id="amountGross"><g:formatNumber number="${session.contract?.amountGross}" format="€ ###,##0.00" /></td></tr>
</table>