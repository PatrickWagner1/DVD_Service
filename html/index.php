<?php
// Verbindungsaufbau und Auswahl der Datenbank
$dbconn = pg_connect("host=192.168.100.11 dbname=dvd_db user=dvd_user password=dvd_password")
    or die('Verbindungsaufbau fehlgeschlagen: ' . pg_last_error());

// Eine SQL-Abfrage ausführen
$query = 'SELECT * FROM test_table';
$result = pg_query($query) or die('Abfrage fehlgeschlagen: ' . pg_last_error());

// Ergebnisse in HTML ausgeben
echo "<table>\n";
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        echo "\t\t<td>$col_value</td>\n";
    }
    echo "\t</tr>\n";
}
echo "</table>\n";

// Speicher freigeben
pg_free_result($result);

// Verbindung schließen
pg_close($dbconn);
?>


