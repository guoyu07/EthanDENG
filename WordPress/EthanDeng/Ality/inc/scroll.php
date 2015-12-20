<ul id="scroll">
	<li><a class="scroll_t" title="返回顶部"><i class="icon-scroll_t"></i></a></li>
	<?php if (get_option('cx_share') == 'true') { ?>
		<li><a href="#share" id="share-main" title="分享"><i class="icon-share"></i></a></li>
	<?php } ?>

	<?php if(is_single() || is_page()) { ?>
		<li><a class="scroll_c" title="查看评论"><i class="icon-scroll_c"></i></a></li>
	<?php } ?>
	<li><a class="scroll_b" title="转到底部"><i class="icon-scroll_b"></i></a></li>
</ul>