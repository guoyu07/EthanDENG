<a href="<?php echo bloginfo('url'); ?>" rel="nofollow" title="按日期排序"> 日期</a>
<a <?php if ( isset($_GET['order']) && ($_GET['order']=='rand') ) echo 'class="current"'; ?> href="<?php echo get_option('home'); ?>/?order=rand" rel="nofollow" title="随机排序"> &gt; 随机</a>
<a <?php if ( isset($_GET['order']) && ($_GET['order']=='commented') ) echo 'class="current"'; ?> href="<?php echo get_option('home'); ?>/?order=commented" rel="nofollow"title="按评论多少排序"> &gt; 评论</a>
<a <?php if ( isset($_GET['order']) && ($_GET['order']=='views') ) echo 'class="current"'; ?> href="<?php echo get_option('home'); ?>/?order=views" rel="nofollow" title="按点击量排序"> &gt; 点击</a>