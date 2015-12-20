<?php
// 评论回应邮件通知
function comment_mail_notify($comment_id) {
  $admin_email = get_bloginfo ('admin_email'); // $admin_email 可改指定的 e-mail.
  $comment = get_comment($comment_id);
  $comment_author_email = trim($comment->comment_author_email);
  $parent_id = $comment->comment_parent ? $comment->comment_parent : '';
  $to = $parent_id ? trim(get_comment($parent_id)->comment_author_email) : '';
  $spam_confirmed = $comment->comment_approved;
  if (($parent_id != '') && ($spam_confirmed != 'spam') && ($to != $admin_email) && ($comment_author_email == $admin_email)) {
    /* 上面的判断式,决定发出邮件的必要条件:
    ($parent_id != '') && ($spam_confirmed != 'spam'): 回复的, 而且不是 spam 才可发, 必需!!
    ($to != $admin_email) : 不发给 admin.
    ($comment_author_email == $admin_email) : 只有 admin 的回复才可发.
    可视个人需求修改以上条件.
    */
    $wp_email = 'no-reply@' . preg_replace('#^www\.#', '', strtolower($_SERVER['SERVER_NAME'])); // e-mail 发出点, no-reply 可改为可用的 e-mail.
    $subject = '您在 [' . get_option("blogname") . '] 的留言有了回应';
    $message = '
    <div style="padding: 15px; font-family: arial, sans-serif;">
      <p style="color: #000; font-weight: bold; background: #F5F5F5; padding: 10px; border: 1px solid #e0e0e0;">' . trim(get_comment($parent_id)->comment_author) . ', 您好!</p>
      <p>您曾在《' . get_the_title($comment->comment_post_ID) . '》的留言:<br /></p>
       <p style="background: #fff; border: 1px solid #e0e0e0; color: #000;  line-height: 180%; padding: 10px; text-indent: 2em;">' . trim(get_comment($parent_id)->comment_content) . '</p>
        <p>' . trim($comment->comment_author) . ' 给您的回应:<br /></p>
       <p style="background: #fff; border:1px solid #e0e0e0; color: #000; line-height: 180%; padding: 10px; text-indent: 2em;">' . trim($comment->comment_content) . '<br /></p>
      <p style="background: #f2f2f2; border: 1px solid #e0e0e0; padding: 10px;">您可以点击 <a href="' . htmlspecialchars(get_comment_link($parent_id)) . '">查看回应完整內容</a></p>
      <p style="text-align: center;">欢迎您再度光临 <a href="' . get_option('home') . '">' . get_option('blogname') . '</a></p>
      <p style="color: #ff0000; font-weight: bold;text-align: center;">此邮件由系统自动发出，请勿回复.</p>
    </div>';
    $from = "From: \"" . get_option('blogname') . "\" <$wp_email>";
    $headers = "$from\nContent-Type: text/html; charset=" . get_option('blog_charset') . "\n";
    wp_mail( $to, $subject, $message, $headers );
    //echo 'mail to ', $to, '<br/> ' , $subject, $message; // for testing
  }
}
add_action('comment_post', 'comment_mail_notify');
 ?>