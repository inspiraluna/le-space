<g:if test="${options}">
<table>
	<tr><td><g:message code="product.priceNet_Gross" />:</td><td align="right"><g:message code="contract.product.${product.id}" /> <g:formatNumber number="${product.priceGross}" format="€ ###,##0.00" /> / <g:formatNumber number="${product.priceNet}" format="€ ###,##0.00" /></td></tr>
	<tr><td><g:message code="contract.options" />:</td><td>
		<g:each in="${options}">
					<p><g:checkBox onClick="loadSum(this.name,this.checked);" name="option_${it.id}" value="${false}" />&nbsp;${g.message(code:'contract.product.'+it.id)} (${g.formatNumber(number:it.priceGross,format:'€ ###,##0.00')}/${g.formatNumber(number:it.priceNet,format:'€ ###,##0.00')})
					</p>
		</g:each>
	</tr>	
	</table>
	<div id="sum">
		<g:render template="sum" />
	</div>
</g:if>
