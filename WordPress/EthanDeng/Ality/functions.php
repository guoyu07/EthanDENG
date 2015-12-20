<?php if (get_option('cx_thumbnails') == 'true') { ?>
<?php get_template_part( '/inc/functions/post-thumbnails' ); ?>
<?php } ?>
<?php if (get_option('cx_remove') == 'true') { ?>
<?php get_template_part( '/inc/functions/remove-g' ); ?>
<?php } ?>
<?php

// 小工具
if (function_exists('register_sidebar')){
	register_sidebar( array(
		'name'          => '首页侧边栏',
		'id'            => 'sidebar-1',
		'description'   => '显示在首页及分类归档页',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget'  => '<div class="clear"></div></aside>',
		'before_title'  => '<h3 class="widget-title"><i class="icon-st"></i>',
		'after_title'   => '</h3>',
	) );
}
if (function_exists('register_sidebar')){
	register_sidebar( array(
		'name'          => '侧边栏',
		'id'            => 'sidebar-2',
		'description'   => '显示在正文、页面、搜索、404页',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget'  => '<div class="clear"></div></aside>',
		'before_title'  => '<h3 class="widget-title"><i class="icon-st"></i>',
		'after_title'   => '</h3>',
	) );
}
if (function_exists('register_sidebar')){
	register_sidebar( array(
		'name'          => '正文底部',
		'id'            => 'sidebar-3',
		'description'   => '显示在正文底部',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget'  => '<div class="clear"></div></aside>',
		'before_title'  => '<h3 class="widget-title"><div class="s-icon"></div>',
		'after_title'   => '</h3>',
	) );
}
if (function_exists('register_sidebar')){
	register_sidebar( array(
		'name'          => '跟随滚动',
		'id'            => 'sidebar-4',
		'description'   => '显示在侧边跟随模块',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget'  => '<div class="clear"></div></aside>',
		'before_title'  => '<h3 class="widget-title"><i class="icon-st"></i>',
		'after_title'   => '</h3>',
	) );
}

// 自定义菜单
register_nav_menus(
   array(
      'top-menu' => __( '顶部菜单' ),
      'header-menu' => __( '导航菜单' ),
      'mini-menu' => __( '按钮菜单' )
   )
);

// 背景
add_theme_support( 'custom-background' );

// feed
add_theme_support( 'automatic-feed-links' );

// 加载前端脚本及样式
function ality_scripts() {
	wp_enqueue_style( 'style', get_stylesheet_uri(), array(), '2014.8.3' );
	wp_enqueue_style( 'mediaqueries', get_template_directory_uri() . '/css/mediaqueries.css', array(), '1.0' );
	wp_enqueue_style( 's', get_template_directory_uri() . '/s', array(), '0' );// 临时
	if ( is_singular() ) {
        wp_enqueue_style( 'highlight', get_template_directory_uri() . '/css/highlight.css', array(), '1.0');
	}
        wp_enqueue_script( 'jquery.min', get_template_directory_uri() . '/js/jquery.min.js', array(), '1.4.2', false );
		wp_enqueue_script( 'script', get_template_directory_uri() . '/js/script.js', array(), '1.0', false );
        wp_enqueue_script( 'jquery.sidr.min', get_template_directory_uri() . '/js/jquery.sidr.min.js', array(), '1.2.1', false );
        wp_enqueue_script( 'jquery.lazyload.min', get_template_directory_uri() . '/js/jquery.lazyload.min.js', array(), '1.9.3', false );
	if ( wp_is_mobile() ){

		}else{
		wp_enqueue_script( 'pc', get_template_directory_uri() . '/js/script-pc.js', array(), '1.0', false );
	}
	if ( is_singular() ) {
		wp_enqueue_script( 'fancybox', get_template_directory_uri() . '/js/fancybox.js', array(), '1.3.4', false);
        wp_enqueue_script( 'mousewheel', get_template_directory_uri() . '/js/mousewheel.js', array(), '3.0.4', false);
        wp_enqueue_script( 'comments-ajax', get_template_directory_uri() . '/js/comments-ajax.js', array(), '1.3', false);
	}
	// 加载回复js
	// if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) {
	// 	wp_enqueue_script( 'comment-reply' );
	// }
}
add_action( 'wp_enqueue_scripts', 'ality_scripts' );

// 移除头部冗余代码
remove_action( 'wp_head', 'wp_generator' );// WP版本信息
remove_action( 'wp_head', 'rsd_link' );// 离线编辑器接口
remove_action( 'wp_head', 'wlwmanifest_link' );// 同上
remove_action( 'wp_head', 'adjacent_posts_rel_link_wp_head', 10, 0 );// 上下文章的url
remove_action( 'wp_head', 'feed_links', 2 );// 文章和评论feed
remove_action( 'wp_head', 'feed_links_extra', 3 );// 去除评论feed
remove_action( 'wp_head', 'wp_shortlink_wp_head', 10, 0 );// 短链接

// 自动缩略图
function catch_image() {
  global $post, $posts;
  $first_img = '';
  ob_start();
  ob_end_clean();
  $output = preg_match_all('/<img.+src=[\'"]([^\'"]+)[\'"].*>/i', $post->post_content, $matches);
  $first_img = $matches [1] [0];

  if(empty($first_img)){
		echo get_bloginfo ( 'stylesheet_directory' );
		echo '/img/default.jpg';
  }
  return $first_img;
}

// 禁止无中文留言
function refused_spam_comments( $comment_data ) {
$pattern = '/[一-龥]/u';  
if(!preg_match($pattern,$comment_data['comment_content'])) {
err('评论必须含中文！');
}
return( $comment_data );
}
add_filter('preprocess_comment','refused_spam_comments');

// 评论链接新窗口
function commentauthor($comment_ID = 0) {
    $url    = get_comment_author_url( $comment_ID );
    $author = get_comment_author( $comment_ID );
    if ( empty( $url ) || 'http://' == $url )
		echo $author;
    else
		echo "<a href='$url' rel='external nofollow' target='_blank' class='url'>$author</a>";
}

// 主题小工具
require get_template_directory() . '/inc/functions/widgets.php';

// 主题设置
require get_template_directory() . '/inc/theme-options.php';
require get_template_directory() . '/inc/guide.php';

// 评论模板
require get_template_directory() . '/inc/functions/comment-template.php';

// 评论通知
require get_template_directory() . '/inc/functions/notify.php';

// 热门文章
require get_template_directory() . '/inc/functions/hot-post.php';

// 分页
require get_template_directory() . '/inc/functions/pagenavi.php';

// 面包屑导航
require get_template_directory() . '/inc/functions/breadcrumb.php';

// 图片属性
require get_template_directory() . '/inc/functions/addclass.php';

// 文章类型
require get_template_directory() . '/inc/functions/post-type.php';

// 禁止代码标点转换
remove_filter( 'the_content', 'wptexturize' );

// 友情链接
add_filter( 'pre_option_link_manager_enabled', '__return_true' );

// 去掉描述P标签
function deletehtml($description) {
$description = trim($description);
$description = strip_tags($description,"");
return ($description);
}
add_filter('category_description', 'deletehtml');

// 下载按钮
function button_a($atts, $content = null) {
return '<div id="down"><a id="load" title="下载链接" href="#button_file"><i class="icon-down"></i>下载地址</a><div class="clear"></div></div>';
}
add_shortcode("file", "button_a");

// 编辑器增强
 function enable_more_buttons($buttons) {
     $buttons[] = 'hr';
     $buttons[] = 'del';
     $buttons[] = 'sub';
     $buttons[] = 'sup';
     $buttons[] = 'fontselect';
     $buttons[] = 'fontsizeselect';
     $buttons[] = 'cleanup';
     $buttons[] = 'styleselect';
     $buttons[] = 'wp_page';
     $buttons[] = 'anchor';
     $buttons[] = 'backcolor';
     return $buttons;
     }
add_filter( "mce_buttons_3", "enable_more_buttons" );

// 编辑器按钮
add_action('after_wp_tiny_mce', 'bolo_after_wp_tiny_mce');
function bolo_after_wp_tiny_mce($mce_settings) {
?>
<script type="text/javascript">
QTags.addButton( 'file', '下载按钮', "[file]" );
function bolo_QTnextpage_arg1() {
}
</script>
<?php }

// 后台预览
add_editor_style( '/css/editor-style.css' );

// 跳转到设置
if (is_admin() && $_GET['activated'] == 'true') {
header("Location: themes.php?page=theme-options.php");
}
// 禁用工具栏
show_admin_bar(false);


// 全部结束
?>