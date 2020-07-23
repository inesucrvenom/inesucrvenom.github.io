<?php require_once(VIEW_PATH.'header.inc.php'); ?>

	<?php foreach($posts as $post): ?>

    <h4>
        <?php echo $post->title;?>
        (<?php echo format_date($post->created);?>)
    </h4>

    <p>
        <?php echo $post->summary;?>
        <a href="read.php?id=<?php
        echo $post->id;?>"><?php echo $read_more?></a>
    </p>

<?php endforeach; ?>

<?php require_once(VIEW_PATH.'footer.inc.php'); ?>