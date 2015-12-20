<div id="login">
<?php get_currentuserinfo();global $current_user, $user_ID, $user_identity;	if( !$user_ID || '' == $user_ID ) { ?>
	<h1>用户登录</h1>
	<form action="<?php echo wp_login_url( get_permalink() ); ?>" method="post" id="loginform">
		<fieldset id="inputs">
			<input id="username" type="text"  name="log" id="log" placeholder="名称" required>
			<input id="password" type="password" name="pwd" id="pwd" placeholder="密码" required>
		</fieldset>
		<fieldset id="actions">
		<input type="submit" id="submit" value="登录">
		<input type="hidden" name="redirect_to" value="<?php echo $_SERVER[ 'REQUEST_URI' ]; ?>" />
		<label><input type="checkbox" name="rememberme" id="modlogn_remember" value="yes"  checked="checked" alt="Remember Me" >记住登录信息</label>
		</fieldset>
	</form>
<?php } ?>
<?php global $user_identity,$user_level;get_currentuserinfo();if ($user_identity) { ?>
	<div class="login-user">
		<h1>管理网站</h1>
		<?php echo get_avatar( get_the_author_email(), '64' ); ?>
		登录者：<?php echo $user_identity; ?><br/>
		<?php wp_register('', ''); ?><br/>
		<a href="<?php echo wp_logout_url( get_bloginfo('url') ); ?>" title=""> 退出</a>
	</div>
 <?php } ?>
</div>