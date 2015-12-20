<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>">
<meta name="viewport" content="width=device-width initial-scale=1.0, user-scalable=no">
<?php get_template_part( 'inc/seo' ); ?>
<link rel="shortcut icon" href="<?php bloginfo('template_directory'); ?>/img/favicon.ico">
<link rel="profile" href="http://gmpg.org/xfn/11">
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">
<!--[if lt IE 9]>
<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js"></script>
<script src="<?php echo get_template_directory_uri(); ?>/js/css3-mediaqueries.js" type="text/javascript"></script>
<![endif]-->
<!--[if lt IE 7]><script src="<?php echo get_template_directory_uri(); ?>/js/ie6.js" type="text/javascript"></script><![endif]-->
<!--[if lt IE 8]><link rel="stylesheet" href="<?php bloginfo('template_url'); ?>/css/ie7/ie7.css" /><![endif]-->
<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<div id="main" class="wrapper">
	<div id="header-top">
		<nav id="top-nav" class="main-nav">
			<div class="home_h"><i class="icon-home_h"><a href="<?php echo bloginfo('url'); ?>" title="返回首页"></a></i></div>
			<?php wp_nav_menu( array( 'theme_location' => 'top-menu' ) ); ?>
			<div class="clear"></div>
		</nav>
	</div>
	<?php get_template_part( 'inc/simple-menu' ); ?>
	<div id="page" class="page-site">
		<header id="header">
			<div class="header-clear"></div>
			<div class="main-header">
				<?php get_template_part( 'inc/logo' ); ?>
				<?php get_template_part( 'inc/nav-set' ); ?>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<nav id="site-nav" class="main-nav">
				<?php wp_nav_menu( array( 'theme_location' => 'header-menu' ) ); ?>
				<ul><li class="fill"></li></ul>
			</nav>
			<!-- #site-nav -->
			<div class="clear"></div>
		</header>
		<!-- #header -->
	<div id="search-main">
		<?php get_search_form(); ?>
		<?php get_template_part( 'inc/search-baidu' ); ?>
	</div>
	<?php the_crumbs(); ?>
	<?php if (get_option('cx_bulletin') == 'true') { ?>
		<?php get_template_part( 'inc/bulletin' ); ?>
	<?php } ?>