<form action="http://www.baidu.com/baidu" target="_blank">
	<input name=word class="swap_value" placeholder="百度站内搜索" required >
	<input type="submit" class="submit" name="submit" id="searchsubmit" value="百度" />
	<input name=tn type=hidden value="bds">
	<input name=cl type=hidden value="3">
	<input name=ct type=hidden value="2097152">
	<input name=si type=hidden value="<?php echo get_option('cx_baidu_s'); ?>">
	<input name=si type=hidden value="">
</form>