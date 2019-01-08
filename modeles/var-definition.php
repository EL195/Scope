<?php // require_once('../controlleurs/css-import.php');?>




<?php

require_once('../class/DatabaseStatement.class.php');
require_once('../fonctions/Fonctions.php');
    $db = new DatabaseStatement();
   $titre_site = "Scope";

   $FatalQueryResult = "<h1 style='color:red;'>les Paramètres de la requete n'ont pas été transmis ou session inexistante
   <h3>connecter vous<a href='../controlleurs' style='font-size: 25px; color:blue;'> ici</a></h3>";
$ErrorSendParam = "<h1 style='color:red;'>les Paramètres de la requete n'ont pas été transmises</h1>";
  $db = new DatabaseStatement();

   $devise = ' Fcfa';

 // echo "<h1 style='color:red;'>".$sqlErrors."</h1>";
 ?>
<?php  //require_once('../controlleurs/js-import.php');?>
