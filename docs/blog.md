---
layout: default
title: Blog
---
{% include header.html %}

<div class="spacer">  

<ul class="list-group">
{% for post in site.posts %}
	<li class="list-group-item">
    	<span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>&nbsp;&nbsp;
		<span class="lead"><a class="post-link" href="{{ post.url | prepend: site.github.url }}">{{ post.title | escape }}</a></span>
	</li>
{% endfor %}
</ul>

</div>

<div class="spacer"> 
<p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | prepend: site.github.url }}">via RSS</a></p>
</div>
