<?php if ( get_post_meta($post->ID, 'thumbnail', true) ) : ?>
<?php $image = get_post_meta($post->ID, 'thumbnail', true); ?>
<a href="<?php the_permalink() ?>" rel="bookmark" title="<?php the_title(); ?>"><img src="<?php bloginfo('template_directory'); ?>/img/load.gif" data-original="<?php echo $image; ?>" alt="<?php the_title(); ?>" />
</a>
<?php else: ?>
<a href="<?php the_permalink() ?>" rel="bookmark" title="<?php the_title(); ?>">
<?php if (has_post_thumbnail()) { the_post_thumbnail('thumbnail', array('alt' => get_the_title()));
} else { ?>
<img class="home-thumb" src="<?php bloginfo('template_directory'); ?>/img/load.gif" data-original="<?php echo catch_image() ?>" alt="<?php the_title(); ?>" />
<?php } ?></a>
<?php endif; ?>