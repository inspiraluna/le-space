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
          <div id="coworkingweek_city" class="coworkingweek"></div>
<script type="text/javascript" src="http://www.inspiraluna.de:8080/coworkingweek/js/prototype/prototype.js"></script>
<script type="text/javascript" src="http://www.inspiraluna.de:8080/coworkingweek/event/mashupCity/Leipzig"></script>
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