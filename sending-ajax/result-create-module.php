<?php
require_once('../modeles/var-definition.php');

if ( isset($_POST['nom_table']) && isset($_POST['colonne_out']) && isset($_POST['id_out']) && isset($_POST['valeur'])){

    $table = $_POST['nom_table'];
    $colonne_out = $_POST['colonne_out'];
    $id_out = $_POST['id_out'];
    $valeur = $_POST['valeur'];


    if(!empty($valeur)){
        $sql = "INSERT INTO ".$table." (".strtoupper($colonne_out).") values(?) ";
        $data = [validateInput($valeur)];

        if ($db->execute_update($sql,$data)){
            echo $db->getColumnToCombo("SELECT * FROM ".$table,$colonne_out,$id_out);
            $delay = 3000;
            $msg = "LA VALEUR ".validateInput($valeur)." A ETE AJOUTER";
            $titre = "ENREGISTREMENT DANS ".$table;
            $data = ["delay"=>$delay, "msg"=>$msg,"title"=>$titre];
            showNotification('success', $data);
        }else{

        }
    }


} else{
    die($FatalQueryResult);
}

?>