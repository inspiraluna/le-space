<div id="facebookFeed" class="feed">
  <h3><a href="http://www.facebook.com/pages/Leipzig-Germany/le-space/288080760878?v=app_2344061033&amp;ref=ts">Veranstaltungen</a></h3>
  loading...
</div>
<!-- Script für die Twitter, Facebook und Blog Mashups -->
<script type="text/javascript">
   function getFacebookFeed(feed) {
      var newScript = document.createElement('script');
          newScript.type = 'text/javascript';
          newScript.src = 'http://pipes.yahoo.com/pipes/9oyONQzA2xGOkM4FqGIyXQ/run?&_render=json&_callback=facebookPiper&feed='+feed;
      document.getElementsByTagName("head")[0].appendChild(newScript);
   }
   function facebookPiper(feed) {

      var tmp='<h3><a href="http://www.facebook.com/pages/Leipzig-Germany/le-space/288080760878?v=app_2344061033&amp;ref=ts">Veranstaltungen</a></h3>';
      tmp+='<ul>';
      for (var i=0; i<feed.value.items.length; i++) {
          tmp+='<li>'+humane_date(feed.value.items[i].pubDate)+' <a href="http://www.facebook.com'+feed.value.items[i].link+'" target="_blank">';
          tmp+=feed.value.items[i].title+'</a></li>';
          if(i==2){break;}
      }
      tmp+='</ul>';
      document.getElementById('facebookFeed').innerHTML=tmp;
   }
   <g:if env="production">
    getFacebookFeed(escape("http://pipes.yahoo.com/pipes/pipe.run?_id=a1d693bd4ad9655ccb12e631498d3100&_render=rss"));
   </g:if>
</script>
