<table>
  <tr><td><g:message code="product.priceNet_Gross" />:</td><td align="right">
  <g:message code="contract.product.${(session.contract?.getProducts() && session.contract?.getProducts()?.size()>0)?(session.contract.getProducts().toArray().sort{it.id})[0].id:null}" />
  (<g:formatNumber number="${(session.contract?.getProducts() && session.contract?.getProducts()?.size()>0)?(session.contract.getProducts().toArray().sort{it.id})[0].priceGross:0}" format="€ ###,##0.00" /> /
  <g:formatNumber number="${(session.contract?.getProducts() && session.contract?.getProducts()?.size()>0)?(session.contract.getProducts().toArray().sort{it.id})[0].priceNet:0}" format="€ ###,##0.00" />)</td></tr>
  <tr><td><g:message code="contract.options.label" />:</td><td>
  <g:each in="${session.options}" var="item">
    <p><g:checkBox onClick="loadSum(this.name,this.checked);"
                 name="option_${item?.id}"
                 value="${session.contract?.getProducts()?.toArray().find{ it==item }}" />&nbsp;${g.message(code:'contract.product.'+item?.id)} (${g.formatNumber(number:item.priceGross,format:'€ ###,##0.00')}/${g.formatNumber(number:item?.priceNet,format:'€ ###,##0.00')})
    </p>
</g:each>
</tr>	
</table>
<div id="sum">
  <g:render template="sum" />
</div>

