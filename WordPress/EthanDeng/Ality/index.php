<?php get_header(); ?>
<div id="primary" class="site-content">
	<?php if ( is_sticky() ) { ?>
		<?php get_template_part( 'inc/sticky' ); ?>
	<?php } ?>
	<?php $temp = $wp_query; $wp_query= null; $wp_query = new WP_Query(); $wp_query->query('cat='.get_option('cx_cat_s').'&caller_get_posts=8'.'&paged='.$paged); ?>
	<?php get_template_part( 'inc/orderby' ); ?>
	<?php if ( have_posts() ) : ?>
	<?php while ( have_posts() ) : the_post(); ?>
		<?php get_template_part( 'content' ); ?>
	<?php endwhile; ?>
	<?php else : ?>
	<section class="content">
		<p>目前还没有文章！</p>
		<p><a href="<?php echo get_option('siteurl'); ?>/wp-admin/post-new.php">点击这里发布您的第一篇文章</a></p>
	</section>
	<?php endif; ?>
	<nav id="pagenavi"><?php pagenavi(); ?></nav>
</div>
<!-- #primary -->
<?php get_sidebar(); ?>
<?php get_footer(); ?> 