<div id="bdtj">
	<div id="<?php echo stripslashes(get_option('cx_bdtj_s')); ?>"></div>
</div>
<style type="text/css">
#bdtj {
	background: #fff;
	margin: 0 0 10px 0;
	padding: 0;
	border: 1px solid #ccc;
}
.hm-t-header {
	border-bottom: none !important;
	height:24px !important;
}
.hm-t-container{
	padding: 5px 0 0 15px !important;
	width: 95% !important;
	height: 160px !important;
}
.hm-t-footer{
	display: none;
}

/** 等于或小于680px **/
@media screen and (max-width: 680px) {
	#bdtj {
		display: none;
	}
}
</style>