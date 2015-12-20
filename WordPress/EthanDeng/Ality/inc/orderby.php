<?php
	if ( isset($_GET['order']) )
	{
	    switch ($_GET['order'])
	    {
	        case 'rand' : $orderby = 'rand'; break;
	        case 'commented' : $orderby = 'comment_count'; break;
	        default : $orderby = 'title';
	    }
	    global $wp_query;
	    if($_GET['order'] == 'views') {
			$args = array( 'meta_key' => 'views', 'orderby' => 'meta_value_num');
		} else {
			$args= array('orderby' => $orderby, 'order' => 'DESC');
		}
	    $arms = array_merge($args, $wp_query->query);
	    query_posts($arms);
	}
?>