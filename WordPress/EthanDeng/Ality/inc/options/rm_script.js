jQuery(document).ready(function(){
	jQuery('.rm_options').slideUp();
	jQuery('.rm_section h3').click(function(){
		jQuery(this).parent().next('.rm_options').slideToggle('slow');
	});
});