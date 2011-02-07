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

      <h2>logins by customer id 119</h2>
      <table>
      <g:each in="${loginsByCustomer}" status="j" var="i">
        <tr>
          <td>${i}</td>
        </tr>
      </g:each>
      </table>

      <h2>logins by month order by month</h2>
      <table>
      <g:each in="${loginsByMonthYear}" status="j" var="i">
        <tr>
          <td>${i[0]}</td>
          <td>${i[1]}</td>
        </tr>
      </g:each>
      </table>

      <h2>logins by date</h2>
      <table>
      <g:each in="${loginsByDate}" status="j" var="i">
        <tr>
          <td>${new org.joda.time.DateTime(i[1].getTime()).getWeekOfWeekyear()}</td>
          <td>${i[1]}</td>
          <td>${i[0]}</td>          
        </tr>
      </g:each>
      </table>

      <h2>revenue by month order by amount</h2>
      <table>
      <g:each in="${revenueByMonth}" status="j" var="i">
        <tr>
          <td>${i[0]}</td>
          <td>${i[1]}</td>
        </tr>
      </g:each>
      </table>

     <h2>revenue by month order by month & year</h2>
      <table>
      <g:each in="${revenueByMonthOrderByDateDesc}" status="j" var="i">
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
