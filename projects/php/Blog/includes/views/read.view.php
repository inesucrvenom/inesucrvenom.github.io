<?php require_once(VIEW_PATH.'header.inc.php'); ?>

    <h3><?php echo $post->title; ?></h3>
    (<?php echo format_date($post->created);?>)

    <p>
        <?php echo $post->content; ?>
    </p>

<?php require_once(VIEW_PATH.'footer.inc.php'); ?>