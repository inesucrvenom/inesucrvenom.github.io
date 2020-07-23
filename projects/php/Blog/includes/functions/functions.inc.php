<?php

/* direct user to new page */
function redirect_to($url)
{
    if (isset($url)) {
        header("Location: " . $url);
    }
}

/* format date as (d.m.yyyy.)*/
function format_date($input_date)
{
    return date("j.n.Y", strtotime($input_date));
}
