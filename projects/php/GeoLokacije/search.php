
<?php
/**
 * Query database for city given in request
 */

// init database connection
$user = array("ines", "ucim", "localhost"); //username, password, host
$database = "geo";
$db = new mysqli($user[2], $user[0], $user[1], $database);
if($db->connect_error){
    echo "# Error connecting to the database: " . $db->connect_error;
    exit;
}

// ensuring output consistency
$db->set_charset('utf8');

// getting search term
$input = $_REQUEST["q"];
if ($input == ""){
    echo "Enter some city name first.";
    exit;
}


// search, and generate output table

$output = "<table><tbody>".PHP_EOL;

// preventing injection using binding parameters
$query_search = $db->prepare("SELECT * FROM Location WHERE `city` LIKE ?");
$input .= "%";
$query_search->bind_param('s', $input);
$query_search->execute();

$result = $query_search->get_result();
if ($result->num_rows <= 0){
    echo "No data found";
    exit;
}

// generate output table rows
while($row = $result->fetch_assoc()){
    $output .= "    <tr><td>";
    $output .= implode("</td><td>", $row);
    $output .= "</td></tr>" . PHP_EOL;
}

$output .= "</tbody></table>";


// clean and close
$query_search->free_result();
$db->close();

echo $output;

?>
