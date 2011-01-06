<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="admin" />
</head>
<body>
<div id="koerper">
<g:render template="/common/admin/infos" />
<div id="inhalt">
<div class="zweispaltig">

<h1>Stats</h1>

      <h2>revenue by month</h2>
      <table>
      <g:each in="${revenueByMonth}" status="j" var="i">
        <tr>
          <td>${i[0]}</td>
          <td>${i[1]}</td>
        </tr>
      </g:each>
      </table>

      <h2>revenue by customer</h2>
      <table>
      <g:each in="${revenueByCustomer}" status="j" var="i">
        <tr>
          <td>${i[0]}</td>
          <td>${i[1]}</td>
        </tr>
      </g:each>
     </table>

</div>

<div class="clear"></div>
</div>
</body>
</html>
