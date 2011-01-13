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
<h1><g:message code="contract.profile.label" default="Profil" /></h1>
<p>&nbsp;</p> 
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
<p>&nbsp;</p>
<div class="ausklappen"><a href="javascript:schiebe('passwordChange');"><g:message code="contract.profile.changePassword.label" default="Change Password" /></a></div>
<div id="passwordChange">
 <g:render template="/shiroUser/passwordChange" />
</div>
<div class="ausklappen"><a href="javascript:schiebe('customerData');"><g:message code="contract.profile.customerData.label" default="Customer Data" /></a></div>
<div id="customerData">
 <g:render template="/customer/customerData" />
</div>
<div class="ausklappen"><a href="javascript:schiebe('customerContracts');"><g:message code="contract.profile.customerContracts.label" default="Customer Contracts" /></a></div>
<div id="customerContracts">
 <g:render template="/customer/customerContracts" />
</div>
<div class="ausklappen"><a href="javascript:schiebe('addContract');"><g:message code="contract.profile.addContract.label" default="Add Contract" /></a></div>
<div id="addContract">
 <g:render template="/customer/addContract" />
</div
<div class="ausklappen"><a href="javascript:schiebe('bankAccount');"><g:message code="contract.profile.bankAccount.label" default="Bank Account" /></a></div>
<div id="bankAccount">
 <g:render template="/contract/bankAccount" />
</div


</div>

<div class="clear"></div>
</div>
  <script type="text/javascript">
//Dieser Teil ist für die Schieber verantwortlich.
var oldLayer = null;
function schiebe(layer){
  //schließe alten layer
  //	if(oldLayer!=null)
  //         Effect.toggle(oldLayer, 'slide');
  //speichere neuen layer als es als altes element
  Effect.toggle(layer, 'slide');
  //öffne neues element
  oldLayer = layer;
  //return false;
  }

$('passwordChange').hide();
$('customerData').hide();
$('customerContracts').hide();
$('bankAccount').hide();
</script>
</body>
</html>
