<?php
require_once ('var-definition.php');

if ( isset($_POST['nom_table']) && isset($_POST['nom_colonne']) && isset($_POST['valeur']) ){

    $table = $_POST['nom_table'];
    $colonne = $_POST['nom_colonne'];
    $valeur = $_POST['valeur'];


    if(!empty($valeur)){
        $sql = "INSERT INTO ".$table." (".$colonne.") values(?) ";
        $data = [validateInput($valeur)];

        if ($db->execute_update($sql,$data)){
             $delay = 3000;
             $msg = "LA VALEUR ".validateInput($valeur)." A ETE AJOUTER";
             $titre = "ENREGISTREMENT DANS ".$table;
            $data = ["delay"=>$delay, "msg"=>$msg,"title"=>$titre];
            showNotification('success', $data);
           // header('Location: cadre.php?pages=login.php');
        }else{

        }
    }



} else{
    die($FatalQueryResult);
}

?>