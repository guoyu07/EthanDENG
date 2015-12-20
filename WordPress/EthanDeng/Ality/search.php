<?php get_header(); ?>
<div id="primary" class="site-content">
	<?php if ( have_posts() ) : ?>
	<?php while ( have_posts() ) : the_post(); ?>
		<?php get_template_part( 'content' ); ?>
	<?php endwhile; ?>
	<?php else : ?>
	<section class="content">
		<p>亲！没有您要找的</p>
	</section>
	<?php endif; ?>
	<div id="pagenavi"><?php pagenavi(); ?></div>
	<!-- #navigation -->
</div>
<!-- #primary -->
<?php get_sidebar(); ?>
<?php get_footer(); ?> 