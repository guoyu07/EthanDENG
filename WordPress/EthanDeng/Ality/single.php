<?php get_header(); ?>
<div id="primary" class="site-content">
	<section class="content">
		<?php while ( have_posts() ) : the_post(); ?>
		<?php get_template_part( 'content' ); ?>
	</section>
	<div class="single-tag"><?php the_tags('','',''); ?></div>
	<!-- #content -->
	<div class="authorbio">
		<?php get_template_part( 'inc/copyright' ); ?>
	</div>
	<?php if (get_option('cx_bdtj') == 'true') { ?>
		<?php if ( wp_is_mobile() ){
			echo '';
		    }else{
			get_template_part( 'inc/bdtj' );
		} ?>
	<?php } ?>

	<?php if (get_option('cx_single_w') == 'true') { ?>
		<div id="single-widget">
			<?php dynamic_sidebar( 'sidebar-3' ); ?>
			<div class="clear"></div>
		</div>
	<?php } ?>
	<nav class="nav-single">
		<?php previous_post_link('【上篇】%link') ?><br/><?php next_post_link('【下篇】%link') ?>
	</nav>
	<?php comments_template( '', true ); ?>
	<?php endwhile; ?>
</div>
<!-- #primary -->
<?php get_sidebar(); ?>
<?php get_footer(); ?> 