
<?php

require_once('var-definition.php');


if ( isset($_POST['NomActe']) && isset($_POST['CodePatient']) && isset($_POST['IDDomaine'])) {

    $nom_acte = $_POST['NomActe'];
    $code_patient = $_POST['CodePatient'];
    $id_domaine = $_POST['IDDomaine'];

    $corps = "";
    $err = "";
    $suite_entete =   "</thead>" ."<tbody> ";
    $complet ="";
    $p = false;

    $debut= " <table class='table  table-bordered table-striped'>" .
        "<thead class='tr-entete-table'>" .
        "<tr>" .
        "<th>CodeActe</th>" .
        "<th>Libellé</th>" .
        "<th>Cout</th>" .
        "<th>Quantité</th>" .
        "<th>Montant</th>" .
        "<th>Action</th> "
        . "</tr></thead><tbody> ";

    try {
        $req ="";
        $data = null;
        if(empty($id_domaine)){
            $req = "CALL LISTE_ACTES_D_UN_PATIENT_PAR_DEBUT_NOM(?,?)";
            $data = [validateInput($nom_acte),validateInput($code_patient)];
        }else{
            $req = "CALL LISTE_ACTES_D_UN_DOMAINE_D_UN_PATIENT_PAR_DEBUT_NOM(?,?,?)";
            $data = [validateInput($nom_acte),validateInput($code_patient),$id_domaine];
        }

        $result =  $db->getResultForSelect($req,$data);
        if (empty($result)){
            $corps.= "<tr><td colspan='6' class='td-number'><h2 class='error-result-search'>AUCUNE DONNEES TROUVEES</h2><td></tr>";

        }else{
            foreach ($result as $row){

                $corps .= "<tr >"
                    ."<td>".$row["IDActe"]."</td> "
                    ."<td>".$row["NomActe"]."</td> "
                    ."<td class = 'td-number td-pu' "
                    . "id=\"couta".$row["IDActe"]."\">".$row["CoutActe"].""
                    . "</td> "



                    ."<td class = '' > "
                    . " <input type=\"hidden\" id=\"mt".$row["IDActe"]."\" " .
                    "value='".$row["CoutActe"]."'/>" .
                    "<input type=\"hidden\" id=\"cout".$row["IDActe"]."\" " .
                    " value='".$row["CoutActe"]."'  /> " .
                    "<div class=\"wrap-input100 input-qte\" >" .
                    "<input class=\"input100\" type=\"number\"  " .
                    "id=\"qte".$row["IDActe"]."\" " .
                    " value=\"1\"" .
                    " oninput=\"getMontant('".$row["IDActe"]."');\"" .
                    " required=\"true\"/>\n" .
                    "  <span class=\"focus-input100\"></span>" .
                    "</div>"
                    . "</td> "

                    ."<td class = 'td-number' "
                    . "id='mta".$row["IDActe"]."'>".$row["CoutActe"].""
                    . "</td> "

                    ."<td class=\"td-add-commande\" "
                    . "onclick=\" executeCommande({action:'add',
                    idproduct:'".$row["IDActe"]."',idpatient:'".$code_patient."',qtec:$('#qte".$row["IDActe"]."').val(),mt:$('#mt".$row["IDActe"]."').val()}); searchacte();  ct('Facturation-NetApayerGrand');\"> "
                    . "<button type='button' class='btn btn-success' >"
                    . "<span class=\" fa fa-plus-square-o\" > Ajouter</span>"
                    . "  </button>"
                    . "</td> "

                    . "</tr>";
            }
        }

    } catch (Exception $e) {

    }

        echo $debut.$corps."</tbody></table>";
 
}else{
    die($ErrorSendParam);
}

?>
