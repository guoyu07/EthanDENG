<?php if ( is_home()&&!is_paged() ){ ?>
<div id="links">
	<ul>
	<?php
		if(function_exists('wp_hot_get_links')){
		wp_hot_get_links();
		}else{
		wp_list_bookmarks('title_li=&categorize=0&category=&orderby=rand&show_images=&limit=100');
		}
	?>
	</ul>
	<div class="clear"></div>
</div>
<?php } ?>