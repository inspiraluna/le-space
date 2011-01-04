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
          <h1 class="first">Nutzer bei Le Space</h1>
          <p>Wenn Ihr in den Coworking Space kommt, ist es möglich, dass Ihr auf folgende Menschen und Firmen trefft...</p>
          <g:each in="${customerList}" satus="i" var="entry"><g:if test="${entry?.email}">${entry.publicationHTML}<aaaavatargravatar email="${entry?.email}" defaultGravatarUrl="kontakt@le-space.de"/></g:if></g:each>
          <hr />
        </div>
        <div class="einspaltig">
          <div id="twitterFeed" class="feed"><g:render template="/common/twitterFeed" /></div>
          <g:render template="/common/coworkingFeed" />
          <g:render template="/common/facebookFeed" />
        </div>
      </div>
      <div class="clear"></div>
    </div>
  </body>
</html>