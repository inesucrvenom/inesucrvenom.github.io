<?php

/*
 * Import csv into database, into empty table (overwrite, not append).
 * Usage: php -f import.php filename database username:password@host
 * */

$usage = "# Usage: php -f import.php filename database username:password@host \n";

if (count($argv) <> 4){
    echo $usage;
    exit;
}


// init database connection using command line arguments
$user = preg_split("/[:@]/", $argv[3]);
$database = $argv[2];
$db = new mysqli($user[2], $user[0], $user[1], $database);
if($db->connect_error){
    echo "# Error connecting to the database: " . $db->connect_error;
    echo "\n" . $usage;
    exit;
}

// ensuring input consistency
$db->set_charset('utf8');


// clear table or create new
$query_check_table = "DESCRIBE Location";
$query_trunc = "TRUNCATE TABLE Location;";
$query_create = "CREATE TABLE Location (
locId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
country VARCHAR(2) CHARACTER SET utf8 NOT NULL default '',
region VARCHAR(2) CHARACTER SET utf8 NOT NULL default '',
city VARCHAR(100) CHARACTER SET utf8 NOT NULL default '' ,
postalCode VARCHAR(10) CHARACTER SET utf8 NOT NULL default '',
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL,
metroCode INT,
areaCode INT);";

if ($db->query($query_check_table) == true){
    $db->query($query_trunc);
} else {
    $db->query($query_create);
}

if($db->error){
    echo "# Error creating table: " . $db->error;
    exit;
}


// load data from file using command line argument
$filename = $argv[1];
$query_load = "LOAD DATA LOCAL INFILE '". $db->real_escape_string($filename) . "' " .
    "INTO TABLE Location
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '\"'
    IGNORE 1 LINES
    (locId, country, region, city, postalCode, latitude, longitude, metroCode, areaCode);";

$db->query($query_load);
if($db->error){
    echo "# Error loading data: " . $db->error;
    exit;
}


// clean and close
$db->close();

?>