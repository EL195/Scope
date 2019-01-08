
<?php
require_once ('var-definition.php');
if ( isset($_POST['code'])  ){
    $req = "CALL COUT_TOTAL_COMMANDE_TEMP_D_UN_PATIENT(?,?)";
    $data = [validateInput($_POST['code']),$user];
    $result = $db->getOnresult($req,$data);
  /*  if(empty($result)){
        echo $result->CT;
    }else{
        echo $result->CT;
    } */echo $result->CT;

} else{
    die($FatalQueryResult);
}

?>
      
   
    
   
      
