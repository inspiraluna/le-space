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
<h1 class="first">Über <i><i>Le Space</i></i> - Coworking in Leipzig</h1>

<p>Den eigenen Abeitsplatz indiviuell gestalten?  Ort und Zeit selbst bestimmen? Interessanten Menschen begegnen? Im <i>Le Space</i> (beta) ist alles möglich.</p>

<p>Von Berlin bis New York: Freiberufler, digitale Nomaden und Angestellte mit hohem Homeoffice-Anteil arbeiten zusammen an einem Ort. Und: Gemeinsam an der Idee, international vernetzt ein Konzept neuer Arbeit zu entwickeln.
<i>Le Space</i> ist der erste Coworking-Space in Leipzig: flexibel, individuell und entspannt.</p>

<h1>Welche Vorteile bietet mir Coworking @ Le Space?</h1>
<div class="ausklappen"><a href="javascript:schiebe('vorteil01');">Einfach die bestehende Infrastruktur nutzen</a></div>

<div id="vorteil01">
<p>Im <i>Le Space</i> ist aller Anfang leicht. Egal, ob Schreibtisch, Drucker oder Scanner: Wir stellen das gesamte Equipment zur Verfügung. Weil das Arbeitsumfeld einfach und unkompliziert sein muss. Ohne die Lieblingspalme oder das
Foto vom Stubentiger geht nichts? Dauer-User können natürlich ihren Arbeitsplatz individuell gestalten.</p>
</div>

<div class="ausklappen"><a href="javascript:schiebe('vorteil02');">Volle Flexibilität</a></div>

<div id="vorteil02">
<p>Bei <i>Le Space</i> wird nur die Zeit bezahlt, die man auch wirklich bei uns arbeitet.
So individuell und flexibel wie die eigenen Arbeitszeiten: <i>Le Space</i> ist immer da.
Entweder mit unserem 9-18.00-Uhr-Tarif (Mo-Fr) oder zum 24/7 Abo. </p>
</div>

<div class="ausklappen"><a href="javascript:schiebe('vorteil03');">Social Innovation</a></div>

<div id="vorteil03">
<p>Isoliert, unproduktiv und blockiert? <i>Le Space</i> kennt das nicht. Unterschiedliche Menschen aus verschiedenen Berufszweigen und Branchen treffen bei uns aufeinander.
Input durch Austausch: In entspannter Arbeitsatmosphäre und bei einer Tasse Kaffee kann man über die eigenen Projekte reden. Und wenn die Deadline näher rückt: Durch  mobile Desks lassen sich private Spaces gestalten.</p>
</div>

<div class="ausklappen"><a href="javascript:schiebe('vorteil04');">Coworking Visa</a></div>

<div id="vorteil04">
<p><i>Le Space</i> nimmt am weltweiten Coworking Visa teil. Das bedeutet, dass sie in anderen teilnehmenden Coworking Spaces in der Welt z.T.
kostenlos arbeiten können. <a href="http://coworking.pbworks.com/CoworkingVisa" target="_blank"> (Click Coworking Visa)</a></p>
</div>
<!--
<div class="ausklappen"><a href="javascript:schiebe('vorteil05');">ॐ Yoga inside ॐ</a></div>

<div id="vorteil05">
<p><i>Le Space</i> wird zukünftig auch verschieden Techniken & Methoden aus dem klassischen indischen Yoga zur Entspannung und Ausgleich anbieten.
Das bedeutet ganz konkret <i>Hatha-Yoga</i> (körperliche Übungen) jeden Freitag vor dem Jelly um 8.30 - 10 Uhr ab 23.4.2010!
Meditationen und Entspannungsübungen zu anderen Tagen und Tageszeiten sind für die nächsten Monate in der Planung.</p>
</div> -->


</div>
<div class="einspaltig">

<div id="twitterFeed" class="feed"><g:render template="/common/twitterFeed" /></div>
<g:render template="/common/coworkingFeed" />
<g:render template="/common/facebookFeed" />
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

$('vorteil01').hide();
$('vorteil02').hide();
$('vorteil03').hide();
$('vorteil04').hide();
//$('vorteil05').hide();

</script>
</body>
</html>