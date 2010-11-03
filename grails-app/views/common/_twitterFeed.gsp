<h3><a href="http://www.twitter.com/inspiraluna">Twitter:@le_space_beta</a></h3>
loading...

<!-- Script für die Twitter Mashup -->
<script type="text/javascript">
function getTwitterFeed(feed) {
  var newScript = document.createElement('script');
  newScript.type = 'text/javascript';
  newScript.src = 'http://pipes.yahoo.com/pipes/9oyONQzA2xGOkM4FqGIyXQ/run?&_render=json&_callback=twitterPiper&feed='+feed;
  document.getElementsByTagName("head")[0].appendChild(newScript);
}

function twitterPiper(feed) {
  var tmp='<h3><a href="http://www.twitter.com/le_space_beta">Twitter:@le_space_beta</a></h3>';
  tmp+='<ul>';
  for (var i=0; i<feed.value.items.length; i++) {
          tmp+='<li>'+humane_date(feed.value.items[i].pubDate)+' <a href="'+feed.value.items[i].link+'" target="_blank">';
          tmp+=feed.value.items[i].title+'</a></li>';
    if(i==3){break;}
  }
  tmp+='</ul>';
  document.getElementById('twitterFeed').innerHTML=tmp;
}
<g:if env="production">
    getTwitterFeed(escape("http://pipes.yahoo.com/pipes/pipe.run?_id=35651097218f9238bcacd240467c3855&_render=rss"));
</g:if>
</script>