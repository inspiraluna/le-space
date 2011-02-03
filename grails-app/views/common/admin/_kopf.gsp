<div id="kopf">
  <div id="logo"><img src="${createLinkTo(dir:'img',file:'logo_LeSpace.gif')}" alt="Le Space - Coworking in Leipzig" width="163" height="163" /></div>
  <div id="navi_slogan">
     <shiro:hasRole name="Administrator"><div id="hauptnavi">
      <ul>
        <li class="first coworking"><a href="${createLinkTo(dir:'contract/list')}">Verträge</a></li>
        <li class="user"><a href="${createLinkTo(dir:'customer/list')}">Kunden</a></li>
        <li class="raeume"><a href="${createLinkTo(dir:'shiroUser/list')}">Nutzer</a></li>
        <li class="raeume"><a href="${createLinkTo(dir:'product/list')}">Produkte</a></li>
        <li class="preise"><a href="${createLinkTo(dir:'contract/stat')}">Statistik</a></li>
        <shiro:isLoggedIn><li><li class="logout"><g:link controller="auth" action="signOut"><shiro:principal/> <g:message code="login.signOut" /></g:link></shiro:isLoggedIn><div class="clear"></div></li>
      </ul>
     </shiro:hasRole>
    </div>
  </div>
  <div class="clear"></div>
</div>
