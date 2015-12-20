<?php echo get_avatar( get_the_author_email(), '64' ); ?>
<ul class="spostinfo">
	<?php if ( get_post_meta($post->ID, 'copyright', true) ) : ?>
	<?php $copy = get_post_meta($post->ID, 'copyright', true); ?>
	<li><strong>版权声明：</strong> 本文为转载文章，源于互联网，由<?php the_author_posts_link('namefl'); ?>整理，<strong><a target="_blank" rel="nofollow" href="<?php echo $copy ?>" >原文链接</a></strong></li>
	<li><strong>转载请注明：</strong><a href="<?php the_permalink() ?>" rel="bookmark" title="本文固定链接 <?php the_permalink() ?>"><?php the_title(); ?> | <?php bloginfo('name');?></a><a href="#" onclick="copy_code('<?php the_permalink() ?>'); return false;"> +复制链接</a></li>
	<?php else: ?>
	<li><strong>版权声明：</strong>本站原创文章，由<?php the_author_posts_link('namefl'); ?>发表在<?php the_category(', ') ?>分类下，于<?php the_modified_date('Y年m月d日'); ?>最后更新</li>
	<li><strong>转载请注明：</strong><a href="<?php the_permalink() ?>" rel="bookmark" title="本文固定链接 <?php the_permalink() ?>"><?php the_title(); ?> | <?php bloginfo('name');?></a><a href="#" onclick="copy_code('<?php the_permalink() ?>'); return false;"> +复制链接</a></li>
	<?php endif; ?>
</ul>