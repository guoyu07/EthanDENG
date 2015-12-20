<?php
/*
Template Name: 近期留言
*/
?>
<?php get_header(); ?>
<div id="primary" class="site-content">
	<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
		<section class="content">
			<?php while ( have_posts() ) : the_post(); ?>
			<div id="message" class="message-page">
				<ul>
					<?php
					$show_comments = 30;
					$my_email = get_bloginfo ('admin_email');
					$i = 1;
					$comments = get_comments('number=200&status=approve&type=comment');
					foreach ($comments as $my_comment) {
							if ($my_comment->comment_author_email != $my_email) {
								?>
								<li>
									<a href="<?php echo get_permalink($my_comment->comment_post_ID); ?>#comment-<?php echo $my_comment->comment_ID; ?>" title="发表在 > <?php echo get_the_title($my_comment->comment_post_ID); ?>" >
										<?php echo '<img class="avatar" src="' . get_bloginfo('template_directory') . '/img/gravatar.png" alt="avatar" data-original="' . preg_replace(array('/^.+(src=)(\"|\')/i', '/(\"|\')\sclass=(\"|\').+$/i'), array('', ''), get_avatar($my_comment->comment_author_email,64)) . '" />'; ?>
										<strong><div class="comment_author"><?php echo $my_comment->comment_author; ?></div></strong>
										<?php echo convert_smilies($my_comment->comment_content); ?>
									</a>
								</li>
								<?php
								if ($i == $show_comments) break;
								$i++;
							}
					}
					?>
				</ul>
			</div>
			<!-- #message -->
		</section>
	<!-- #content -->
	<?php endwhile; ?>
	</article>
</div>
<!-- #primary -->
<?php get_sidebar(); ?>
<?php get_footer(); ?> 