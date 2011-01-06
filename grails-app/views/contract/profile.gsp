<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<shiro:hasRole name="Administrator"><meta name="layout" content="admin" /></shiro:hasRole>
<shiro:hasRole name="User"><meta name="layout" content="main" /></shiro:hasRole>
</head>
<body>
<div id="koerper">
  <shiro:hasRole name="Administrator"><g:render template="/common/admin/infos" /></shiro:hasRole>
  <shiro:hasRole name="User"><g:render template="/common/infos" /></shiro:hasRole>
</div>
<div id="inhalt">
<div class="zweispaltig">

<h1><g:message code="contract.profile.welcome" default="Welcome" /> ${shiroUser.firstname} ${shiroUser.lastname} (${shiroUser.username})</h1>

<p>
Ihr Vertrag läuft vom:
  <b><g:formatDate date="${contract.contractStart}" format="dd.MM.yyyy"/></b>
 bis: <b><g:formatDate date="${contract.contractEnd}" format="dd.MM.yyyy"/></b><br/>
und verlängert sich <b>${!contract.autoExtend?"<font color='red'>nicht</font>":""} automatisch.</b><br/>
ihr gewählten Produkte sind: <b>${contract.selectedProducts}</b><br/>
Sie waren <b>${contract.loginDays}</b> Tage im Coworking Space.<br/>
Ihr letzter Login: <b><g:formatDate date="${contract.lastLogin}" format="dd.MM.yyyy hh:mm:ss"/></b><br/>
Rechnungstatus ist: <b>${contract.paid?message(code: 'contract.profile.paid'):message(code: 'contract.profile.unpaid')}</b><br/>
</p>
</div>

<div class="clear"></div>
</div>
</body>
</html>
