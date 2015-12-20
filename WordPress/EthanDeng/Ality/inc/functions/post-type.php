<?php
// 公告
add_action( 'init', 'post_type_bulletin' );
function post_type_bulletin() {
	$labels = array(
		'name'               => _x( '公告', 'post type general name', 'your-plugin-textdomain' ),
		'singular_name'      => _x( '公告', 'post type singular name', 'your-plugin-textdomain' ),
		'menu_name'          => _x( '公告', 'admin menu', 'your-plugin-textdomain' ),
		'name_admin_bar'     => _x( '公告', 'add new on admin bar', 'your-plugin-textdomain' ),
		'add_new'            => _x( '发布公告', 'bulletin', 'your-plugin-textdomain' ),
		'add_new_item'       => __( '发布新公告', 'your-plugin-textdomain' ),
		'new_item'           => __( '新公告', 'your-plugin-textdomain' ),
		'edit_item'          => __( '编辑公告', 'your-plugin-textdomain' ),
		'view_item'          => __( '查看公告', 'your-plugin-textdomain' ),
		'all_items'          => __( '所有公告', 'your-plugin-textdomain' ),
		'search_items'       => __( '搜索公告', 'your-plugin-textdomain' ),
		'parent_item_colon'  => __( 'Parent 公告:', 'your-plugin-textdomain' ),
		'not_found'          => __( '你还没有发布公告。', 'your-plugin-textdomain' ),
		'not_found_in_trash' => __( '回收站中没有公告。', 'your-plugin-textdomain' )
	);

	$args = array(
		'labels'             => $labels,
		'public'             => true,
		'publicly_queryable' => true,
		'show_ui'            => true,
		'show_in_menu'       => true,
		'query_var'          => true,
		'rewrite'            => array( 'slug' => 'bulletin' ),
		'capability_type'    => 'post',
		'has_archive'        => true,
		'hierarchical'       => false,
		'menu_position'      => 5,
		'supports'           => array( 'title', 'editor', 'author', 'comments' )
	);

	register_post_type( 'bulletin', $args );
}

// 公告分类
add_action( 'init', 'create_bulletin_taxonomies', 0 );
function create_bulletin_taxonomies() {
	$labels = array(
		'name'              => _x( '公告分类目录', 'taxonomy general name' ),
		'singular_name'     => _x( '公告分类', 'taxonomy singular name' ),
		'search_items'      => __( '搜索公告目录' ),
		'all_items'         => __( '所有公告目录' ),
		'parent_item'       => __( 'Parent Genre' ),
		'parent_item_colon' => __( 'Parent Genre:' ),
		'edit_item'         => __( '编辑公告目录' ),
		'update_item'       => __( '更新公告目录' ),
		'add_new_item'      => __( '添加新公告目录' ),
		'new_item_name'     => __( 'New Genre Name' ),
		'menu_name'         => __( '公告分类' ),
	);

	$args = array(
		'hierarchical'      => true,
		'labels'            => $labels,
		'show_ui'           => true,
		'show_admin_column' => true,
		'query_var'         => true,
		'rewrite'           => array( 'slug' => 'notice' ),
	);

	register_taxonomy( 'notice', array( 'bulletin' ), $args );
}
?>