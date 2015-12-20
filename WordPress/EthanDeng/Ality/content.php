<?php if ( is_home() || is_category() || is_search() || is_tag() || is_month() || is_author() || is_day() || is_month() || is_year() ) : ?>
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
	<section class="content">
		<?php get_template_part( 'inc/new' ); ?>
		<header class="entry-header">
			<div class="title-heavy"><div class="heavy-l"></div><div class="heavy-r"></div></div>
			<h1 class="entry-title"><a href="<?php the_permalink(); ?>" rel="bookmark" title="详细阅读 <?php the_title(); ?>"><?php the_title(); ?></a></h1>
		</header>
		<!-- .entry-header -->
		<div class="entry-content">
			<figure class="thumbnail">
				<?php get_template_part( 'inc/thumbnail' ); ?>
			</figure>
			<div class="entry-site">
				<?php if (has_excerpt()){ ?>
					<?php the_excerpt() ?>
				<?php } else { echo mb_strimwidth(strip_tags(apply_filters('the_content', $post->post_content)), 0, 380,"..."); } ?>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div class="entry-meta">
				<span class="meta-site">
					<span class="date"><i class="icon-date"></i><?php the_time( 'Y年m月d日' ) ?></span>
					<span class="cat"><i class="icon-cat"></i><?php the_category( ', ' ) ?></span>
					<span class="comment"><i class="icon-comment"></i><?php comments_popup_link( '暂无评论', '评论 1 条', '评论 % 条' ); ?></span>
					<?php if( function_exists( 'the_views' ) ) { print '<span class="views"><i class="icon-views"></i>阅读 '; the_views(); print ' 次</span>';  } ?>
					<?php edit_post_link( '<span class="edit"><i class="icon-edit"></i>编辑', ' ', '</span>'); ?>
				</span>
				<span class="entry-more"><a href="<?php the_permalink(); ?>" rel="bookmark" title="阅读全文 <?php the_title(); ?>">阅读全文</a></span>
			</div>
			<!-- .entry-meta -->
		</div>
		<!-- .entry-content -->
	</section>
	<!-- #content -->
</article>
<?php endif; ?>

<?php if ( is_single() ) : ?>
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
	<header class="single-header">
		<h1 class="single-title"><?php the_title(); ?></h1>
		<div class="single-meta">
			<span class="date"><i class="icon-date"></i><?php the_time( 'Y年m月d日' ) ?></span>
			<span class="cat"><i class="icon-cat"></i><?php the_category( ', ' ) ?></span>
			<span class="comment"><i class="icon-comment"></i><?php comments_popup_link( '暂无评论', '评论 1 条', '评论 % 条' ); ?></span>
			<?php if( function_exists( 'the_views' ) ) { print '<span class="views"><i class="icon-views"></i>阅读 '; the_views(); print ' 次</span>';  } ?>
			<?php edit_post_link( '<span class="edit"><i class="icon-edit"></i>编辑', ' ', '</span>'); ?>
		</div>
		<!-- .entry-meta -->
	</header>
	<!-- .single-header -->

	<div class="single-content">
		<?php the_content(); ?>
		<?php get_template_part( 'inc/file' ); ?>
		<?php wp_link_pages(array('before' => '<div class="page-links">', 'after' => '', 'next_or_number' => 'next', 'previouspagelink' => '<span>上一页</span>', 'nextpagelink' => "")); ?><?php wp_link_pages(array('before' => '', 'after' => '', 'next_or_number' => 'number', 'link_before' =>'<span>', 'link_after'=>'</span>')); ?>
		<?php wp_link_pages(array('before' => '', 'after' => '</div>', 'next_or_number' => 'next', 'previouspagelink' => '', 'nextpagelink' => "<span>下一页</span>")); ?>
		<div class="clear"></div>
	</div>
	<!-- .single-content -->
</article>
<?php endif; ?>

<?php if ( is_page() ) : ?>
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
	<header class="single-header">
		<h1 class="single-title"><?php the_title(); ?></h1>
		<div class="single-meta">
			<span class="date"><i class="icon-date"></i><?php the_time( 'Y年m月d日' ) ?></span>
			<span class="comment"><i class="icon-comment"></i><?php comments_popup_link( '暂无评论', '评论 1 条', '评论 % 条' ); ?></span>
			<?php if( function_exists( 'the_views' ) ) { print '<span class="views"><i class="icon-views"></i>阅读 '; the_views(); print ' 次</span>';  } ?>
			<?php edit_post_link( '<span class="edit"><i class="icon-edit"></i>编辑', ' ', '</span>'); ?>
		</div>
		<!-- .entry-meta -->
	</header>
	<!-- .single-header -->

	<div class="single-content">
		<?php the_content(); ?>
		<?php wp_link_pages(array('before' => '<div class="page-links">', 'after' => '', 'next_or_number' => 'next', 'previouspagelink' => '<span>上一页</span>', 'nextpagelink' => "")); ?><?php wp_link_pages(array('before' => '', 'after' => '', 'next_or_number' => 'number', 'link_before' =>'<span>', 'link_after'=>'</span>')); ?>
		<?php wp_link_pages(array('before' => '', 'after' => '</div>', 'next_or_number' => 'next', 'previouspagelink' => '', 'nextpagelink' => "<span>下一页</span>")); ?>
		<div class="clear"></div>
	</div>
	<!-- .single-content -->
</article>
<?php endif; ?>