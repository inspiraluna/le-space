<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div id="koerper">
      <g:render template="/common/infos" />
      <div id="inhalt">
        <div class="dreispaltig">
          <p>Coworking ist das produktive Arbeiten mit Gleichgesinnten in einer kreativen Atmosphäre. Coworking Spaces sind halböffentliche Räume in einer Mischung zwischen Großraumbüro, konzentriertem Arbeitsplatz und Café.<br />
            Im Mittelpunkt steht die Schaffung von flexiblen, offenen, digital vernetzten Arbeitsräumen für unabhängige Kreative und Teams. Mit Coworking Spaces entstehen reale Orte, in denen man gern selbstständig arbeitet und Personen mit gleichen Interessen treffen kann.</p>
          <p>Le Space ist Leipzigs erster Coworking Space. Wir bieten flexible und fixe Arbeitsplätze, WLAN und Drucker.<br />
            <a href="coworking">Mehr Informationen über Le Space - Coworking in Leipzig…</a></p>
        </div>
        <div class="dreispaltig">
          <g:if env="production">
          <iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fle.space.beta&amp;layout=standard&amp;show_faces=true&amp;width=500&amp;action=like&amp;font=verdana&amp;colorscheme=light&amp;height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:80px;" allowTransparency="true"></iframe></center>
          </g:if>
        </div>
       
        <div id="twitterFeed" class="feed first"><g:render template="/common/twitterFeed" /></div>
        <g:render template="/common/coworkingFeed" />
        <g:render template="/common/facebookFeed" />
      </div>
      <div class="clear"></div>
    </div>
  </body>
</html>