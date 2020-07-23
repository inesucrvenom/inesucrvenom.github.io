<?php

// Initialize site configuration
require_once('includes/config.inc.php');

// Get posts from database
$posts = Post::getAll();

// Include page view
require_once(VIEW_PATH.'index.view.php');