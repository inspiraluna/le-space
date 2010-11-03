<div id="coworkingFeed" class="feed">
  <h3><a href="http://www.coworking-leipzig.de">Coworking Leipzig Blog</a></h3>
  loading...
</div>
<!-- Script für das Blog Mashup -->
<script type="text/javascript">
   function getCoworkingFeed(feed) {
      var newScript = document.createElement('script');
          newScript.type = 'text/javascript';
          newScript.src = 'http://pipes.yahoo.com/pipes/9oyONQzA2xGOkM4FqGIyXQ/run?&_render=json&_callback=coworkingPiper&feed='+feed;
      document.getElementsByTagName("head")[0].appendChild(newScript);
   }
   function coworkingPiper(feed) {
      var tmp='<h3><a href="http://www.coworking-leipzig.de">Coworking Leipzig Blog</a></h3>';
      tmp+='<ul>';
      for (var i=0; i<feed.value.items.length; i++) {
          tmp+='<li>'+humane_date(feed.value.items[i].pubDate)+' <a href="'+feed.value.items[i].link+'" target="_blank">';
          tmp+=feed.value.items[i].title+'</a></li>';
         //tmp+='<li>'+feed.value.items[i].title+'</li>';
         //if (feed.value.items[i].description) {
            //tmp+=feed.value.items[i].description;
         //}
          if(i==5){break;}
      }
      tmp+='</ul>';
      document.getElementById('coworkingFeed').innerHTML=tmp;
   }
   <g:if env="production">
    getCoworkingFeed(escape("http://www.coworking-leipzig.de/feed/"));
   </g:if>
</script>
