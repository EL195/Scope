

<?php

require_once('var-definition.php');


//if (isset($_POST['idpatient'])  || isset($_POST['action']) ) {
    $corps = "";
     //$code_patient = $_POST['idpatient'];


   /* $debut= " <table class='table  table-bordered table-striped'>" .
        "<thead class='tr-entete-table'>" .
        "<tr>" .
        "<th>CodeActe</th>" .
        "<th>Libellé</th>" .
        "<th>Cout</th>" .
        "<th>Quantité</th>" .
        "<th>Montant</th>" .
         "<th>Remise</th>" .
        "<th>Action</th> "
        . "</tr></thead><tbody> ";*/

    try {
        $req ="";
        $req_action = "";
        $data_action = null;
        $data_list_commande = null;
      if ( isset($_POST['action']) ){
          if ( $_POST['action'] == "add" && isset($_POST['qtec']) && isset($_POST['mt']) && isset($_POST['idproduct']) && isset($_POST['idpatient']) ){
              if ($_POST['qtec']>0 && $_POST['mt']>0 && !empty($_POST['idproduct']) && !empty($_POST['idpatient'])){
                  $req_action = "CALL ADD_COMMANDE_TEMP(?,?,?,?,?)";
                  $data_action = [$user,validateInput($_POST['idpatient']),$_POST['idproduct'],$_POST['qtec'],$_POST['mt']];
                 // echo "<h1> req action = ".$req_action ."</h1>";
              }

          }else if ($_POST['action'] == "del" && isset($_POST['idproduct']) && isset($_POST['idpatient']) ){
              $req_action = " CALL DELETE_COMMANDE_TEMP(?,?,?)";
              $data_action = [$user,validateInput($_POST['idpatient']),$_POST['idproduct']];
              // echo "<h1> req action = ".$req_action ."</h1>";
          }
          $db->execute_update($req_action,$data_action);
      }




        $req_list_commande = " CALL DETAILS_COMMANDE_TEMP(?,?)";
        $data_list_commande = [validateInput($_POST['idpatient']),$user];

       // die ("<h1>".$req_list_commande."</h1>");

        if (isset($_POST['idpatient'])  || isset($_POST['idproduct']) ) {
            $result =  $db->getResultForSelect($req_list_commande,$data_list_commande);
            if (empty($result)){
                $corps= "<tr><td colspan='7' class='td-number'><h2 class='error-result-search'>AUCUNE COMMANDE TROUVEE</h2><td></tr>";

            }else{
                foreach ($result as $row){
                    $corps .= "<tr >"
                        ."<td>".$row["IDActe"]."</td> "
                        ."<td>".$row["NomActe"]."</td> "
                        ."<td class = 'td-number td-pu' "
                        . "id=\"cout".$row["IDActe"]."\">".$row["CoutActe"].""
                        . "</td> "
                        ."<td >".$row["Qte"]."</td> "
                        ."<td class = 'td-number'>".$row["Montant"]."</td> "
                        ."<td>0%</td> "

                        ."<td "
                        . "onclick=\" executeCommande({action:'del',idproduct:'".$row["IDActe"]."',idpatient:'".$_POST['idpatient']."'});ct('Facturation-NetApayerGrand');\"> "
                        . "<button type='button' class='btn btn-danger' >"
                        . "<i class=\" fa fa-trash\" > Supprimer</i>"
                        . "  </button>"
                        . "</td> "

                        . "</tr>";
                }
            }
        }



    } catch (Exception $e) {

    }
        echo $corps;
    exit();

/*}else{
     die($ErrorSendParam);
}*/



?>
