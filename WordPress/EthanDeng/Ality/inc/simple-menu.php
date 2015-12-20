<div id="simple-top">
	<a id="simple-menu" href="#sidr"><i class="icon-simple-menu"></i></a>
	<?php if (get_option('cx_title') == 'logo') { ?>
		<hgroup class="logo-simple">
			<div class="site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home" title="<?php bloginfo('name'); ?>"><h1 class="logo-x"><?php bloginfo('name'); ?></h1></a></div>
		</hgroup>
	<?php } else { ?>
		<hgroup class="logo-simple">
			<div class="site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home" title="<?php bloginfo('name'); ?>"><h1 class="logo-title"><?php bloginfo('name'); ?></a></h1></div>
		</hgroup>
	<?php } ?>
	<div id="set-top">
		<div id="nav-search">
			<a class="menu-search" href="#"><i class="icon-search"></i></a>
		</div>
		<div id="nav-login">
			<a href="#login" class="flatbtn" id="logint-main" ><i class="icon-login"></i></a>
		</div>
	</div>
</div>