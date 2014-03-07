<?PHP
$db = mysql_connect('192.168.0.241', 'root', 'i.AM');

mysql_select_db('mysql', $db) or die(mysql_error($db));

$query = 'SELECT host,db,user FROM db';
$result = mysql_query($query, $db) or die(mysql_error($db));

if(mysql_num_rows($result) > 0){
	while($row = mysql_fetch_array($result)){
	echo 'host: '.$row['host'].'<br />';
	echo 'db: '.$row['db'].'<br />';
	echo 'user: '.$row['user'].'<br />';
	}
}

mysql_free_result($result);
mysql_close($db);

// TEST CODE
echo '<br />Test Code: <br />';
echo cal_days_in_month(0,11,2011);

// TEST CODE
echo '<br />Test Code: <br />';
echo passthru('ping localhost');
?>