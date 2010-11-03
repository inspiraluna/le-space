<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div id="koerper">
      <g:render template="/common/infos" />
      <div id="inhalt">
        <div id="inhalt">

          <div class="dreispaltig">
            <h1 class="first">Preise</h1>

            <table cellspacing="0">
              <thead>
                <tr><th class="first" rowspan="2">&nbsp;</th><th colspan="2">Basispakete</th><th colspan="3">Optionen</th></tr>
                <tr><th>Flex</th><th>Fix</th><th>Schlüssel</th><th>Schließfach</th><th>Briefkasten</th></tr>
              </thead>
              <tfoot>
                <tr><td colspan="6" class="first">Preisliste gültig ab 8. März 2010. Alle Preise inkl. MwSt<br />
                    *einlösbar innerhalb von 4 Wochen
                    *** einlösbar innerhalb von 3 Monaten
                  </td></tr>
              </tfoot>
              <tbody>
                <tr><td class="first">Tageskarte</td><td>10&nbsp;€</td><td>-</td><td>-</td><td>3&nbsp;€</td><td>-</td></tr>
                <tr class="ungerade"><td class="first">Wochenkarte</td><td>39&nbsp;€</td><td>-</td><td>-</td><td>12&nbsp;€</td><td>-</td></tr>
                <tr><td class="first">12er Karte *</td><td>69&nbsp;€</td><td>-</td><td>29&nbsp;€</td><td>15&nbsp;€</td><td>50&nbsp;€</td></tr>
                <tr class="ungerade"><td class="first">Monatskarte</td><td>119&nbsp;€</td><td>169&nbsp;€</td><td>29&nbsp;€</td><td>inkl.</td><td>50&nbsp;€</td></tr>
                <tr><td class="first">10er Karte **</td><td>90&nbsp;€</td><td>-</td><td>29&nbsp;€</td><td>15&nbsp;€</td><td>50&nbsp;€</td></tr>
              </tbody>
            </table>

          </div>

          <div class="zweispaltig">
            <h2>Öffnungszeiten</h2>
            <p>"Le Space (beta)" hat Montag bis Freitag von 09:00 Uhr bis 18:00 Uhr für alle Nutzer ohne Voranmeldung und ohne Bewerbung geöffnet.</p>
            <p> Bei Flex-Tarifen muss der Schreibtisch bei Verlassen wieder abgeräumt werden.<br/>
              Der Fixdesk-Tarif ist persönlicher exklusiv gemieteter Arbeitsplatz. Hier kann auch über Nacht persönliches (wie z.B. Schreibmaterial, Bücher, Laptop, etc.) liegen bleiben.</p>
            <p>User mit eigenem Schlüssel können auch nach 18 Uhr und am Wochenende und gesetzl. Feiertagen in den Coworking Space.</p>
            <h2 class="extra">Kostenlose Jellys</h2>
            <p>Jeden Freitag ab 10.00 Uhr veranstalten wir ein sogenanntes "Jelly", zu dem Ihr Eueren Laptop, Arbeit und Brötchen fürs gemeinsame Frühstück und anschließendem Coworking mitbringen könnt. Jelly's sind kostenlos.</p>
          </div>

          <div class="einspaltig">
            <g:if env="prod-production">
            <div id="twitterFeed" class="feed"><g:render template="/common/twitterFeed" /></div>
            <g:render template="/common/coworkingFeed" />
            <g:render template="/common/facebookFeed" />
            </g:if>
          </div>

        </div>
        <div class="clear"></div>
      </div>
  </body>
</html>