<?php
	$t1=$post->post_date;
	$t2=date("Y-m-d H:i:s");
	$t3=get_option('cx_date');
	$diff=(strtotime($t2)-strtotime($t1))/3600;
	if($diff<$t3){ echo'<span class="new-ico">NEW</span>'; }
?>