<?php
require_once('../var-definition.php');
  function getListActebyNamebyDomaine($NomActe,$CodePatient,$IDDomaine){


      $corps = "";
        $err = "";
         $suite_entete =   "</thead>" ."<tbody> ";
         $complet ="";
        
        
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
    
     
       $p = false;
        try {
            $req ="";
            $iddomaine =0;
            if(empty($IDDomaine)){
                $req = "CALL LISTE_ACTES_D_UN_PATIENT_PAR_DEBUT_NOM('".NomActe."','".CodeP."')";
            }else{
                $req = "CALL LISTE_ACTES_D_UN_DOMAINE_D_UN_PATIENT_PAR_DEBUT_NOM('".$NomActe."','".$CodePatient."',".$IDDomaine.")";
            }
              
           
             rs= w.statement.executeQuery(req);
             while (rs.next()){

                 corps .= "<tr >"
                     ."<td>".rs.getString("IDActe")."</td> "
                     ."<td>". rs.getString("NomActe")."</td> "
                     ."<td class = 'td-number td-pu' "
                     . "id=\"couta".rs.getString("IDActe")."\">".rs.getString("CoutActe").""
                     . "</td> "



                     ."<td class = '' > "
                     . " <input type=\"hidden\" id=\"mt".rs.getString("IDActe")."\" " .
                     "value='".rs.getString("CoutActe")."'/>" .
                     "<input type=\"hidden\" id=\"cout".rs.getString("IDActe")."\" " .
                     " value='".rs.getString("CoutActe")."'  /> " .
                     "<div class=\"wrap-input100 input-qte\" >" .
                     "<input class=\"input100\" type=\"number\"  " .
                     "id=\"qte".rs.getString("IDActe")."\" " .
                     " value=\"1\"" .
                     " oninput=\"getMontant('".rs.getString("IDActe")."');\"" .
                     " required=\"true\"/>\n" .
                     "  <span class=\"focus-input100\"></span>" .
                     "</div>"
                     . "</td> "

                     ."<td class = 'td-number' "
                     . "id=\"mta".rs.getString("IDActe")."\">".rs.getString("CoutActe").""
                     . "</td> "

                     ."<td class=\"td-add-commande\" "
                     . "onclick=\" executeCommande('".rs.getString("IDActe")."'," .
                     "$('#qte'.'".rs.getString("IDActe")."').val()," .
                     "parseInt($('#mt'.'".rs.getString("IDActe")."').val())," .
                     "$('#Facturation-Code_Patient').val()," .
                     "'result-add-commande-patient'); searchacte();\"> "
                     . "<button type='button' class='btn btn-success' >"
                     . "<span class=\" fa fa-plus-square-o\" > Ajouter</span>"
                     . "  </button>"
                     . "</td> "


                     . "</tr>";
                 p = true;
                 // System.err.println(" p = ".p." debutnom = ".rs.getString("NomPatient"));
             }
            w.closeConnection();
            
        } catch (Exception e) {
          //err=getError(e.getMessage());
          err=e.getMessage();
          System.err.println(" ERREUR RECHERCHER facture detailler pour application remise  = ".e.getMessage());
      }
        if(!p){
            corps.= "<tr><td colspan='6' class='td-number'><h2 class='error-result-search'>AUCUNE DONNEES TROUVEES</h2><td></tr>";
        }
        // System.err.println("err vaut = ".err);
        return debut.corps."</tbody></table>";
      

  }


 function getListPatient($NomPatient,$action){

     $corps = "";
        String err = "";
         String suite_entete =   "</thead>" ."<tbody> ";
         String complet ="";
        
        
        String debut= " <table class='table  table-bordered table-striped'>" .
        "<thead class='tr-entete-table'>" .
        "<tr>" .
        "<th>Code</th>" .
        "<th>Nom</th>" .
        "<th>Prénom</th>" .
        "<th>Sexe</th>" .
        "<th>Né(e) le</th>" .
        "<th>à</th>" .
        "<th>Profession</th>" .
        "<th>Action</th>"
        . "</tr></thead><tbody> ";
    
      String req =" select * from patient where NomPatient like '".NomPatient."%'";
       boolean p = false;
        try {
            String a ="";
           

             while (rs.next()){
                 /*HeureDeces
                 LieuDeces
                 
                 IDTypePatient*/

                 if($action="1")){
                     a = "<td class=' '"
                         ." onclick=\"filltxtFormPatient('". rs.getString("CodePatient")."','". rs.getString("NomPatient")."','". rs.getString("PrenomPatient")."',"
                         . "'". rs.getString("DateNaissance")."','". rs.getString("LieuNaissance")."','". rs.getString("SexePatient")."',"
                         . "'". rs.getString("NiveauScolaire")."','". rs.getString("NomReligion")."',"
                         . "'". rs.getString("NomEthnie")."','". rs.getString("NomProfession")."',"
                         . "'". rs.getString("SituationMatrimoniale")."',"
                         . "'". rs.getString("AdressePatient")."','". rs.getString("TelephonePatient")."',"
                         . "'". rs.getString("EmailPatient")."',"
                         . "'". rs.getString("NomNationalite")."','". rs.getString("NomPays")."',"
                         . "'". rs.getString("NomQuartier")."',"
                         . "'". rs.getString("NomVille")."','". rs.getString("NomPersAPrevenir")."',"
                         . "'". rs.getString("TelPersAPrevenir")."',"
                         . "'". rs.getString("NomPere")."','". rs.getString("NomMere")."')\">"
                         . "<a  data-toggle=\"modal\" data-target=\"#modal-creer-patient\"   "
                         . "class='btn btn-modifier-patient btn-primary btn-sm'>"
                         . " <span class='fa fa-pencil'></span>"
                         . "Modifier</a> "
                         ."</td> " ;
                 }else if(maction=="0"){
                     a = "<td class=''"
                         ." onclick=\"centerNumber('". rs.getString("CodePatient")."')\">"
                         . "<a href='#'  class='btn btn-success btn-sm'>"
                         . " <span class=\"fa fa-check-circle-o\"></span>"
                         . "Selectionner</a> "
                         ."</td> " ;
                 }


                 corps .= "<tr >"
                     ."<td>". rs.getString("CodePatient")."</td> "
                     ."<td>". rs.getString("NomPatient")."</td> "
                     ."<td>". rs.getString("PrenomPatient")."</td> "
                     ."<td>". rs.getString("SexePatient")."</td> "
                     ."<td>". rs.getString("DateNaissance")."</td> "
                     ."<td>". rs.getString("LieuNaissance")."</td> "
                     ."<td>". rs.getString("NomProfession")."</td> "

                     .a



                     /* ."<td onclick=\"fillTxtassurance('".rs.getString("CodeAssurance")."','".rs.getString("NomAssurance")."',"
                          . "'".rs.getString("NomVille")."','".rs.getString("BoitePostale")."','".rs.getString("AdresseAssurance")."',"
                          . "'".rs.getString("TelephoneAssurance")."','".rs.getString("FaxAssurance")."','".rs.getString("EmailAssurance")."',"
                          . "'".rs.getString("NomContactAssurance")."','".rs.getString("TelephoneContactAssurance")."')\"> <center> <img src='../images/icones_20x20/edit.png'> </center></td> " */


                     . "</tr>";
                 p = true;
                 // System.err.println(" p = ".p." debutnom = ".rs.getString("NomPatient"));
             }
            w.closeConnection();
            
        } catch (Exception e) {
        //err=getError(e.getMessage());
        err=e.getMessage();
        System.err.println(" ERREUR RECHERCHER facture detailler pour application remise  = ".e.getMessage());
    }
        if(!p){
            corps.= "<tr><td colspan='8' class='td-number'><h2 class='error-result-search'>AUCUNE DONNEES TROUVEES</h2><td></tr>";
        }
        // System.err.println("err vaut = ".err);
        return debut.corps."</tbody></table>";
    }
    