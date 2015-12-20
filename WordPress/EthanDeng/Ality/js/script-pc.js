/**
 * script v1.0 by Ality.
 * 用于PC端
 */

// 悬停
$(document).ready(function(){
$('.content').hover(
	function() {
		$(this).find('.heavy-r').stop(true,true).fadeIn();
	},
	function() {
		$(this).find('.heavy-r').stop(true,true).fadeOut();
	}
);
});