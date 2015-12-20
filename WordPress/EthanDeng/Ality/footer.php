<?php get_template_part( 'inc/links' ); ?>

<footer id="footer">
	<div class="site-info">
		Copyright &copy; <?php bloginfo( 'name' ); ?>  保留所有权利.&nbsp;&nbsp;
		<span class="info-add">
			主题设计<a title="主题设计：知更鸟" href="http://zmingcx.com" target="_blank"> 知更鸟</a>
			<?php echo stripslashes(get_option('cx_track')); ?>
			<?php echo stripslashes(get_option('cx_icp')); ?>
		</span>
	</div>
	<!-- .site-info -->
<div id="sidr"><?php wp_nav_menu( array( 'theme_location' => 'mini-menu' ) ); ?></div>

<?php get_template_part( 'inc/login' ); ?>

<?php get_template_part( 'inc/scroll' ); ?>

<?php if (get_option('cx_share') == 'true') { ?>
<?php get_template_part( 'inc/share' ); ?>
<?php } ?>

</footer>
<!-- #footer -->
<?php if ( ! is_home() ){ ?>
<script type="text/javascript">
$(".sidebar-roll").smartFloat();
</script>
<?php } ?>
</div><!-- #page -->
</div><!-- #main -->
<?php wp_footer(); ?>
</body>
</html>