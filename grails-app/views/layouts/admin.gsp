<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta name="robots" content="index,follow" />
<meta name="language" content="de" />
<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'general.css')}" type="text/css" media="screen" title="no title" />
<style type="text/css">
 @import url("${createLinkTo(dir:'css',file:'layout.css')}");
 @import url("${createLinkTo(dir:'css',file:'general.css')}");
</style>
<calendar:resources lang="${le.space.HelperTools.getLocale(request)}" theme="tiger"/>
<script src="${createLinkTo(dir:'js',file:'prototype.js')}" type="text/javascript"></script>
<title>Le Space (beta) - Coworking in Leipzig</title>
<meta name="description" content="Le Space ist Leipzigs erster Coworking Space. Wir bieten flexible und fixe Arbeitsplätze, WLAN und Drucker." />
<meta name="keywords" content="Coworking, Coworking Space, Büro, Arbeitsplatz, Arbeitsraum" />
</head>

<body id="${bodyId?bodyId:''}">
<grender template="/common/kopf" />
<g:layoutBody />
<div id="footer"></div>
</body>
</html>