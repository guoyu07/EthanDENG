<div id="bulletin_div" class="bulletin_div">
	<div id="bulletin_begin">
		<ul>
			<?php 
				$loop = new WP_Query( array( 'post_type' => 'bulletin', 'posts_per_page' => get_option('cx_bulletin_n') ) );
				while ( $loop->have_posts() ) : $loop->the_post();
			?>
			<li><a href="<?php the_permalink(); ?>" target="_blank" title="查看<?php the_title(); ?>"><i class="icon-bulletin"></i><?php echo mb_strimwidth(strip_tags(apply_filters('the_content', $post->post_content)), 0, 88,"..."); ?></a></li>
			<?php endwhile; ?>
			<?php wp_reset_query(); ?>
		</ul>
	</div>
	<div id="bulletin_end"></div>
</div>
<script type="text/javascript">ScrollImgLeft();</script>