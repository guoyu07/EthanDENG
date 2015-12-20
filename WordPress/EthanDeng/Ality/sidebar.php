<div id="sidebar" class="widget-area">
	<?php if ( is_home() || is_archive() ){ ?>
		<?php dynamic_sidebar( 'sidebar-1' ); ?>
	<?php } ?>
	<?php if (is_single() || is_page() || is_search() || is_404() ) { ?>
		<?php dynamic_sidebar( 'sidebar-2' ); ?>
		<div class="sidebar-roll">
			<?php dynamic_sidebar( 'sidebar-4' ); ?>
		</div>
	<?php } ?>
</div>
<div class="clear"></div>