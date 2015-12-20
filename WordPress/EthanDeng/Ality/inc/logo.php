<?php if (get_option('cx_title') == 'logo') { ?>
<hgroup class="logo-main">
	<a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home" title="<?php bloginfo('name'); ?>"><h1 class="logo"><?php bloginfo('name'); ?></h1></a>
</hgroup>
<?php } else { ?>
<hgroup class="logo-main">
	<div class="title-main">
		<h1 class="site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home"><?php bloginfo( 'name' ); ?></a></h1>
		<h2 id="site-description"><?php bloginfo( 'description' ); ?></h2>
	</div>
</hgroup>
<?php } ?>