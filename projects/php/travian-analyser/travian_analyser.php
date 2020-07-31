<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>
  <title>Travian analyser</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

  <style>
    body{
      font-family:Arial,Helvetica,Verdana,sans-serif;
      background-color: #ffffff;
      font-size: 110%;
    }
    span.rome, tr.rome{
      background-color: #ffffcc;
    }
    tr.romefarma{
     /* background-color: #ffff99;*/
      background-color: #ffffaa;
    }
    span.teut, tr.teut{
      background-color: #ccffcc;
    }
    tr.teutfarma{
      /* background-color: #aaffaa; */
      background-color: #99ffbb;
    }
    span.gaul, tr.gaul{
      background-color: #ffcccc;
    }
    tr.gaulfarma{
      /* background-color: #ffaaaa; */
      background-color: #ffbbbb;
    }
    span.natar, tr.natar{
      background-color: #ccccff;
    }
    tr.natarfarma{
      /* background-color: #aaaaff; */
      background-color: #bbbbff;
    }
    td.prazno{
      background-color: #ffffff;
      text-align: center;
    }
    a{
      text-decoration:none;
    }
    a:link{
      color: #000066;
    }
    a:visited{
      color: #6600dd;
    }
    a:hover{
      color: #ff0000;
    }
    a:active{
      color: #9900FF;
    }
  </style>

</head>
<body>
  <table border=\"0\" cellspacing=\"20\" cellpadding=\"10\"><tr>
  <td width="300">
  <form action="index.php" method="get">
    <p><b>Enter coordinates and search radius:</b><br />
    x: <input type="text" name="x" size="3" value="<?= isset($_GET["x"]) ? $_GET["x"] : 0 ?>" maxlength="4" />
    y: <input type="text" name="y" size="3" value="<?= isset($_GET["y"]) ? $_GET["y"] : 0 ?>" maxlength="4" /><br />
    <input type="text" name="rmin" size="3" value="<?= isset($_GET["rmin"]) ? $_GET["rmin"] : 0 ?>" maxlength="4" /><span style="font-size: 117%;"> &le; r &le;</span>
    <input type="text" name="rmax" size="3" value="<?= isset($_GET["rmax"]) ? $_GET["rmax"] : 30 ?>" maxlength="4" /><br />
    <?php
//    echo "<pre>GET: ", print_r($_GET, true), "</pre>";

    if (isset($_GET["x"])) $jax = $_GET["x"];
      else $jax = 0;
    if (isset($_GET["y"])) $jay = $_GET["y"];
      else $jay = 0;
    if (isset($_GET["rmax"])) $jarmax = $_GET["rmax"];
      else $jarmax = 20;
    if (isset($_GET["rmin"])) $jarmin = $_GET["rmin"];
      else $jarmin = 20;

    $chkboxes_options = array(
      "farm" => "Show only farm candidates",
    );

    $chkboxes_tribes = array(
      "rome" => "Romans",
      "teut" => "Teutons",
      "gaul" => "Gauls",
      "natar" => "Natars",
    );

    foreach ($chkboxes_tribes as $key => $value)
      $prikazi_tribes[$key] = (!count($_GET) || isset($_GET[$key]) ? true : false);

    foreach ($chkboxes_options as $key => $value)
      $prikazi_options[$key] = (isset($_GET[$key]) ? true : false);

//    echo "<pre>", print_r($prikazi_tribes, true), "</pre>";

    echo "<br /><b>Choose option:</b><br />";
    foreach ($chkboxes_options as $key => $value)
      echo "<input type=\"checkbox\" name=\"$key\" id=\"chk_$key\" value=\"1\"".(isset($prikazi_options[$key]) && !$prikazi_options[$key] ? "" : " checked=\"checked\"")." /><label for=\"chk_$key\"> $value</label><br />\n";

    echo "<br /><b>Choose tribe(s) to show:</b><br />";
    foreach ($chkboxes_tribes as $key => $value)
      echo "<input type=\"checkbox\" name=\"$key\" id=\"chk_$key\" value=\"1\"".(isset($prikazi_tribes[$key]) && !$prikazi_tribes[$key] ? "" : " checked=\"checked\"")." /><label for=\"chk_$key\"> $value</label><br />\n";

    ?>
      <br /><input type="submit" value="OK" /></p>

  </form>
  </td>

  <td>

  <h2><font color="#6600cc">Find villages near (x|y) in certain radius.</font></h2>
  <h3>About input</h3>
  <p>minimum distance to look <span style="font-size: 117%;"> &lt; r &lt;</span> maximum distance to look (might be used to find targets for troop save)</p>
  <p>There is only one <b>option</b> at the moment - '<b>show only farm candidates</b>'. If selected, in results you'll find only villages which seems inactive (population growth == 0 for certain period of time). If you prefer not to select option - 'farms' will be indicated (in both cases) with sword icons in color of tribe.</p>
  <p><b>Tribe</b> part of checkboxes allow you to be picky and select only your favorite tribe, or some or all of them.</p>
  <p>Options and tribes do not exclude each other - fell free to combine them as you prefer.</p>
  <h3>Results</h3>
  <p>"Pop. growth" field shows village growth of last 7 days: e.g. "0 3 4 1 5 4 (2.4%)" means that village had no growth from yesterday (0), has grown by 3 inhabitants the day before, by 4 three days ago and by 1 four days ago, etc. In total, in last 7 days the village has grown of 2.4% (and gained in total 17 inhabitants). If a number is negative, the village has been attacked or user has destroyed a building. <i>If a village is newer than 7 days, a "(new)" is showed instead of percent. (need checkup)</i></p>
  <p># vill in Player field shows how many villages does player have.<p>
  <p>You can send attacks by click on village name, or raid by click on sword icons (for farm candidates).</p>
  <p>Click on username or alliance - leads you to details on travian website.</p>
  <p>Rows colors are <span class="natar"> Natars</span>, <span class="rome"> Romans</span>, <span class="teut"> Teutons</span> and <span class="gaul"> Gauls</span> (pay attention to the traps!)</p>
  <h3>Tips & Tricks</h3>
  <p>If you see that Pop growth seems weird, and village is Natarian - that means that original user who was on that location on map - is gone, and Natars used that position to form their new village, under same name.</p>
  </td>

  </tr></table>

<?php

if ($_GET) {

//  echo "<p>opening db....</p>";
  $db = mysql_connect("localhost","nesi", "nesi");

  // $jax = -106;
  // $jay = -60;
//  echo "<p>ja: (".$jax.",".$jay."), r=".$jar."</p>";

  mysql_select_db("travian",$db);
  $result = mysql_query("SELECT *, pow(x-'".mysql_real_escape_string($jax)."',2) + pow(y-'".mysql_real_escape_string($jay)."',2) as dist FROM x_world HAVING (dist >= pow('".mysql_real_escape_string($jarmin)."',2) AND dist <= pow('".mysql_real_escape_string($jarmax)."',2) ) ORDER BY dist LIMIT 0, 1000");
  // gleda prvih 1000 rezultata querya

  $broj_redova = mysql_num_rows($result);
  //printf ("<p>No of results to process: %d </p>", $broj_redova);

  // koliko redova u tablici da se ispisuje
  $flag_kraj_ispisa = 100;

  if ($broj_redova == 0)
    printf ("There's no result under these conditions, try different radius.");
    else{

    //tablica
    printf("<table border=\"0\" cellspacing=\"0\" cellpadding=\"6\">");
    printf ("<tr>
    <th> Farm <br /> + Raid </th>
    <th> (x|y) <br /> + Overview </th>
    <th> Village <br /> + Attack </th>
    <th> Distance <br /> + Map </th>
    <th> Pop. Growth </th>
    <th> (%%) </th>
    <th> Pop </th>
    <th> Alliance (#ally) <br /> + Link </th>
    <th> Player (#vill) <br /> + Link</th></tr>");

    //cupaj podatke i printaj
    while ($data = mysql_fetch_object($result)){

      $flag_najstariji_dan = 1; //krece od najstarijeg dana, za iduce dane se drugacije racuna
      $prirast_dan = 0;
      $prirast_suma = 0;
      $query_prirasti = mysql_query("SELECT * FROM prirast WHERE vid=$data->vid ORDER BY datum");
      //ovisno o plemenu 1 = rim, 2 = teut, 3 = gal, 5 = natar - za pripadnu klasu retka
      $tid2tribe = array (1 => "rome", 2 => "teut", 3 => "gaul", 5 => "natar");
      if (isset($tid2tribe[$data->tid]))
        $pleme = $tid2tribe[$data->tid];
        else {
        printf("Error with tid to tribe conversion\n");
	break;
      }

      //prekidaj iteraciju petlje ako se radi o krivom plemenu = neće ispisati taj redak

      if (!$prikazi_tribes[$pleme]) continue;

      //račun prirasta, farma potencijala
      $flag_novi = 8;
      $print_prirast = "";
      $flag_rel_prirast_je_0 = 1;
      $farma = 1;

      while ($data_prirasti = mysql_fetch_object($query_prirasti)){
	if ($flag_najstariji_dan){
	  $old_pop = $data_prirasti->population;
	  $flag_najstariji_dan = 0;

	} else {
	  $prirast_dan = $data_prirasti->population - $old_pop;
	  $old_pop = $data_prirasti->population;
	  $print_prirast = $prirast_dan." ".$print_prirast;
	}
	  $flag_novi--;

	$prirast_suma += $prirast_dan;
	if ($prirast_dan > 0) //farme su oni s prirastom 0 ili manje, svaki dan
	  $farma = 0;
      }

      // prekini iteraciju ako se traze farme, a ovo to nije

      if ( !($farma) && $prikazi_options["farm"]) continue;

      //# ekipa u savezu
      $numally = mysql_num_rows(mysql_query("SELECT * FROM x_world WHERE aid=$data->aid GROUP BY uid"));

      //# villages
      $numvillages = mysql_num_rows(mysql_query("SELECT * FROM x_world WHERE uid=$data->uid"));

      //print retka
      echo "<tr class=\"$pleme".($farma ? "farma" : "")."\">";
      //print farma
      echo "<td class=\"prazno\"> ".(101-$flag_kraj_ispisa)." ";
      $farma ? printf("<a target=\"blank\" href=\"http://ts9.travian.com/a2b.php?z=%d&c=4\" \> <img src=\"%s.gif\" border=\"0\"/></a>", $data->id, $pleme) : printf("&nbsp;");
      echo " </td>";

  //    printf("<tr class=\"%s\">", $pleme);
      //print koordinate + karta link, village + attack link, distance
      printf("
      <td> <a target=\"_blank\" href=\"http://ts9.travian.com/karte.php?d=%d\"> (%d|%d) </a></td>
      <td> <a target=\"_blank\" href=\"http://ts9.travian.com/a2b.php?z=%d\"> %s </a></td>
      <td> <a target=\"_blank\" href=\"http://ts9.travian.com/karte.php?x=%d&y=%d\"> %.4f </a></td>
      <td>",
      $data->id, $data->x, $data->y,
      $data->id, $data->village,
      $data->x, $data->y, sqrt($data->dist)
      );

      //prirast
      printf("%s </td><td>", $print_prirast);
      //print postotak prirasta
      if ($flag_novi)
	printf("(new)</td>");
	else
	if ($data->population - $prirast_suma) printf("(%.2f %%)</td>", $prirast_suma/($data->population - $prirast_suma));
	  else
	  printf("(100 %%)</td>");

      //print pop, savez
      printf("<td> %d </td>", $data->population);
      echo "<td> ".($data->alliance <> "" ? "<a target=\"_blank\" href=\"http://ts9.travian.com/allianz.php?aid=".$data->aid."\">".$data->alliance."</a> ($numally)" : "&nbsp;")."</td>";

      //player + link
      printf("<td> <a target=\"_blank\" href=\"http://ts9.travian.com/spieler.php?uid=%d\"> %s </a>", $data->uid, $data->player);

      // # sela
      printf("(%d) </td></tr>\n", $numvillages);
      if ($flag_kraj_ispisa) $flag_kraj_ispisa--;
        else break;

  //    echo mysql_error(), "<br />\n";
    }
    printf("</table>");
    printf("<br />You've reached the boundary of your world, if you're still curious what's out there - broaden your percpective and try again :)<br />");
  }

//  echo "closing db\n";
  mysql_close($db);
}

?>
</body>
</html>
