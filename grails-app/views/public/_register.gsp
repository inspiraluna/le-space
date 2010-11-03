<p><g:message code="contract.thankyou" /></p>

<g:form name="contract" controller="public" method="post">
  <g:hiddenField name="id" value="${contract.id}" />
  <g:hiddenField name="_format" value="PDF" />
  <ghiddenField name="imageUrl" value="${le.space.HelperTools.getServerAndContext(request)}/public/customerLogo/" />
  <g:hiddenField name="_inline" value="false" />
  <g:hiddenField name="_name" value="contract" />
  <g:hiddenField name="_file" value="contract"  />

  <g:actionSubmit action="contractPdf" controller="public" value="${g.message(code:'contract.print')}" />
</g:form>