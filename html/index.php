<?php
// Verbindungsaufbau und Auswahl der Datenbank
$dbconn = pg_connect("host=192.168.100.11 dbname=dvd_db user=dvd_user password=dvd_password")
    or die('Verbindungsaufbau fehlgeschlagen: ' . pg_last_error());

if(!empty($_GET['sortby'])){
	$sort = " ORDER BY " . $_GET['sortby'];
}else{
	$sort = "";
}

if(!empty($_GET['filter'])){
	$filter = " WHERE Film.title LIKE '%" . $_GET['filter'] . "%'";
}else{
	$filter = "";
}
//$filter = " WHERE Film.title LIKE '%Star Wars" . $_GET['search'] . "%'";


?>


<head>
	<title>DVD Verleih</title>	
</head>
			
				
<h1> 1 Nice DVD Verleih </h1>
<?php
// Eine SQL-Abfrage ausführen
$query = 'SELECT inventory_number as invnr, Film.title as title, Category.name as category, DVD.price as price, Wear.name as status FROM Inventory JOIN DVD ON Inventory.id_DVD=DVD.id JOIN DVD_has_Film ON DVD.id=DVD_has_Film.id_DVD JOIN Film ON Film.id = DVD_has_Film.id_Film JOIN Wear ON Wear.id = Inventory.id_Condition JOIN Category ON DVD.id_category = Category.id' . $filter . $sort;
$result = pg_query($query) or die('Abfrage fehlgeschlagen: ' . pg_last_error());

// Ergebnisse in HTML ausgeben
echo "<table>\n";

echo "<th>Inventarnummer <form action='index.php?sortby=invnr' method='POST'><input type='submit' name=invnr value=&uarr;></form></th>\n";
echo "<th>Titel <form action='index.php?sortby=title' method='POST'><input type='submit' name=title value=&uarr;></form></th>\n";
echo "<th>Kategorie <form action='index.php?sortby=category' method='POST'><input type='submit' name=category value=&uarr;></form></th>\n";
echo "<th>Anschaffungspreis <form action='index.php?sortby=price' method='POST'><input type='submit' name=price value=&uarr;></form></th>\n";
echo "<th>Zustand <form action='index.php?sortby=status' method='POST'><input type='submit' name=status value=&uarr;></form></th>\n";

while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
		echo "\t\t<td>$col_value</td>\n";
		// Die Werte werden eingefügt
		//echo "<td>$line->invnr</td>\n";
		//echo "<td>$line->title</td>\n";
		//echo "<td>$line->category</td>\n";
		//echo "<td>$line->price</td>\n";
		//echo "<td>$line->status</td>\n";
		
    }
    echo "\t</tr>\n";
}
echo "</table>\n";

?>				<!-- Suche nach ... -->
				<form action="index.php" method="post">
				Suche Titel:<br>
				<input type="Text" name="search"><br>
				<input type="Submit" name="filter" value = "Suche"><br>
				</form>
<?php

		if(isset($_POST['filter'])){ // Nach dem Druck auf "Suche" folgt die Überpfüfung
			if(empty($_POST['search'])){ // Feld ausgefüllt?
				echo "Eingabe ung&uuml;ltig! Bitte Feld ausf&uuml;llen!<br><br>";
			}else{ 
				header("Location:index.php?filter=".$_POST['search']);
			}
		}

// Speicher freigeben
pg_free_result($result);

// Verbindung schließen
pg_close($dbconn);
?>

