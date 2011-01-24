<div id="kopf">
  <div id="logo">
    <img src="${createLinkTo(dir:'img',file:'logo_LeSpace.gif')}" alt="Le Space - Coworking in Leipzig" width="163" height="163" />
  </div>
  <div id="navi_slogan">
    <div id="hauptnavi">
      <ul>
        <li class="first coworking"><a href="${createLinkTo(dir:'coworking')}">Über Le Space</a></li>
        <li class="user"><a href="${createLinkTo(dir:'user')}">Nutzer</a></li>
        <li class="raeume"><a href="${createLinkTo(dir:'raum')}">Räume</a></li>
        <li class="preise"><a href="${createLinkTo(dir:'preise')}">Preise</a></li>
        <li class="faq"><a href="${createLinkTo(dir:'faq')}">FAQ</a></li>
        <li class="kontakt"><a href="${createLinkTo(dir:'kontakt')}">Kontakt</a><div class="clear"></div></li>

      </ul>
      <ul>
        <li class="first"><a href="http://www.facebook.com/pages/Leipzig-Germany/le-space/288080760878?v=app_2344061033&amp;ref=ts" target="_blank" class="extern">Veranstaltungen<img src="img/navigation/externerlink_w.gif" alt="(extern)" /></a></li>
        <li><a href="http://www.coworking-leipzig.de/" target="_blank" class="extern">Blog<img src="img/navigation/externerlink_w.gif" alt="(extern)" /></a><shiro:isNotLoggedIn><div class="clear"></div></shiro:isNotLoggedIn></li>
        <li><a href="http://wiki.le-space.de/" target="_blank" class="extern">Wiki</a></li>
        <shiro:isLoggedIn><li class="logout"><g:link controller="auth" id="logout" action="signOut"><shiro:principal/> <g:message code="contract.login.signOut" /></g:link></shiro:isLoggedIn><div class="clear"></div></li>
      </ul>
    </div>
    <div id="subnavi">
      <ul id="subnavi_text">
        <li class="first startseite"><a href="${createLinkTo(dir:'home')}">Startseite</a></li>
        <li class="login"><a href="${le.space.HelperTools.makeSSL(createLinkTo(dir:'login', absolute:true))}">Login</a></li>
        <li class="agb"><a href="${createLinkTo(dir:'agb')}">AGB's</a></li>   
        <li class="impressum"><a href="${createLinkTo(dir:'impressum')}">Impressum</a></li>
        <!--<li><a href="#">english</a></li>-->
      </ul>
      <ul id="subnavi_icons">
        <li><a href="http://www.coworking-leipzig.de/feed""><img src="${createLinkTo(dir:'img/navigation/',file:'rss_feed.gif')}" alt="rss feed" width="16" height="16" /></a></li>
        <li><a href="http://twitter.com/le_space_beta/" target="_blank"><img src="${createLinkTo(dir:'img/navigation/',file:'twitter.gif')}" alt="twitter" width="16" height="16" /></a></li>
        <li><a href="http://www.flickr.com/photos/le-space/" target="_blank"><img src="${createLinkTo(dir:'img/navigation/',file:'flickr.gif')}" alt="flickr" width="16" height="16" /></a></li>
        <li><a href="http://www.facebook.com/le.space.beta" target="_blank"><img src="${createLinkTo(dir:'img/navigation/',file:'facebook.gif')}" alt="facebook" width="16" height="16" /></a></li>
        <li><a href="http://www.coworking.de/places/30" target="_blank"><img src="${createLinkTo(dir:'img/navigation/',file:'coworking_de.png')}" alt="coworking de" width="32" height="16" /></a></li>
      </ul>
    </div>
    <div id="slogan">
      <p> "${slogan}" </p>
    </div>
    <hr />
    <div id="bilder">
      <g:each in="${le.space.Photo.findAll('from Photo as p where p.pageId like \'%'+bodyId+'%\'')}"><a href="${createLinkTo(dir:it.directory,file:it.filename+'.jpg')}" title="${it.title}" rel="lightbox[${it.directory}]"><img src="${createLinkTo(dir:it.directory,file:it.filename+'_k.jpg')}" alt="${it.title}" /></a></g:each>
    </div>
    <hr />
  </div>
  <div class="clear"></div>
</div>
