<?php get_template_part( 'header-bulletin' ); ?>
<div id="primary" class="site-content">
	<section class="content">
		<?php while ( have_posts() ) : the_post(); ?>
			<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
				<header class="single-header">
					<h1 class="single-title"><?php the_title(); ?></h1>
					<div class="single-meta">
						<span class="date"><i class="icon-date"></i><?php the_time( 'Y年m月d日' ) ?></span>
						<span class="cat"><i class="icon-cat"></i><?php echo get_the_term_list( $post->ID,  'notice', '' ); ?></span>
						<span class="comment"><i class="icon-comment"></i><?php comments_popup_link( '暂无评论', '评论 1 条', '评论 % 条' ); ?></span>
						<?php if( function_exists( 'the_views' ) ) { print '<span class="views"><i class="icon-views"></i>阅读 '; the_views(); print ' 次</span>';  } ?>
						<?php edit_post_link( '<span class="edit"><i class="icon-edit"></i>编辑', ' ', '</span>'); ?>
					</div>
					<!-- .entry-meta -->
				</header>
				<!-- .single-header -->

				<div class="single-content">
					<?php the_content(); ?>
					<div class="clear"></div>
				</div>
				<!-- .single-content -->
			</article>
	</section>
	<!-- #content -->
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