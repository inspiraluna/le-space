<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div id="koerper">
      <g:render template="/common/infos" />
      <div id="inhalt">
        <div class="zweispaltig">
          <h1 class="first"><g:message code="contract.register" /></h1>
          <g:if test="${flash.message}">
            <div class="message">
  ${flash.message}
            </div>
          </g:if>
          <g:form name="contract" controller="public" method="post">
            <div id="update">
              <g:render template="step1" />
            </div>
          </g:form>
        </div>
        <div class="einspaltig">         
            <div id="twitterFeed" class="feed"><g:render template="/common/twitterFeed" /></div>
            <g:render template="/common/coworkingFeed" />
            <g:render template="/common/facebookFeed" />
        </div>
        <div class="clear"></div>
      </div>
  </body>
</html>