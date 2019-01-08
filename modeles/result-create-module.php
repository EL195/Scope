<?php

require_once('../var-definition.php');

if ( isset($_POST['nom_table']) && isset($_POST['colonne_out']) && isset($_POST['id_out']) && isset($_POST['valeur'])){

    $table = $_POST['nom_table'];
    $colonne_out = $_POST['colonne_out'];
    $id_out = $_POST['id_out'];
    $valeur = $_POST['valeur'];


    if(!empty($valeur)){
        $sql = "INSERT INTO ".$table." (".$colonne_out.") values(?) ";
        $data = [strtoupper(validateInput($valeur))];

        if ($db->execute_update($sql,$data)){
          //  die("<center><h1>".$db->sqlError."</h1></center>");
            $delay = 15000;
            $position = "top right";
            $msg = "LA VALEUR ".strtoupper(validateInput($valeur))." A ETE AJOUTEE";
            $titre = "ENREGISTREMENT DANS ".$table;
            $data = ["delay"=>$delay, "msg"=>$msg,"title"=>$titre, "position"=>$position];
            showNotification('success', $data);
        }else{
            $delay = 15000;
            $position = "top right";
            $msg = "LA VALEUR ".strtoupper(validateInput($valeur))."N'A PAS ETE AJOUTEE";
            $titre = "ENREGISTREMENT DANS ".$table;
            $data = ["delay"=>$delay, "msg"=>$msg,"title"=>$titre, "position"=>$position];
            showNotification('error', $data);
        }
        echo $db->getColumnToCombo("SELECT * FROM ".$table,$colonne_out,$id_out);
    }




} else{
    die($FatalQueryResult);
}

?>