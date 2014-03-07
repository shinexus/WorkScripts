<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"

  "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

  <meta http-equiv="Content-Type"

        content="text/html; charset=UTF-8">

  <title>SIMPLE mysqli SELECT</title>

</head>

<body>

<?php

  # connect to SQL node:

  $link = new mysqli('192.168.0.241', 'root', 'root', 'mysql');

  # parameters for mysqli constructor are:

  #   host, user, password, database

 

  if( mysqli_connect_errno() )

    die("Connect failed: " . mysqli_connect_error());

 

  $query = "SELECT host, user

            FROM user";

 

  # if no errors...

  if( $result = $link->query($query) )

  {

?>

<table border="1" width="40%" cellpadding="4" cellspacing ="1">

  <tbody>

  <tr>

    <th width="10%">City</th>

    <th>Population</th>

  </tr>

<?

    # then display the results...

    while($row = $result->fetch_object())

      //printf("<tr>\n  <td align=\"center\">%s</td><td>%d</td>\n</tr>\n",
	  printf("<tr>\n  <td align=\"center\">%s</td><td>%s</td>\n</tr>\n",

              $row->host, $row->user);

?>

  </tbody>

</table>

<?

  # ...and verify the number of rows that were retrieved

    printf("<p>Affected rows: %d</p>\n", $link->affected_rows);

  }

  else

    # otherwise, tell us what went wrong

    echo mysqli_error();

 

  # free the result set and the mysqli connection object

  $result->close();

  $link->close();

?>

</body>

</html>