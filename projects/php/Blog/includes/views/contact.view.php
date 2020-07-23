<?php require_once(VIEW_PATH.'header.inc.php'); ?>

<h3>Contact me</h3>

<form method="post">
    <div id="contact-form">
        <div>
            <label for="cf-name">Name</label><br />
            <input type="text" name="cf-name" id="cf-name">
        </div>

        <div>
            <label for="cf-name">Email (required)</label><br />
            <input type="text" name="cf-email" id="cf-email" required aria-required="true">
        </div>

        <div>
            <label for="cf-name">Message (required)</label><br />
            <textarea name="cf-message" id="cf-message" rows="20" required aria-required="true"></textarea>
        </div>

        <input type="submit" value="Send message" />
    </div>
</form>

<?php require_once(VIEW_PATH.'footer.inc.php'); ?>