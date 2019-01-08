
             <!-- breadcumb-->
             <div class="breadcome-area mg-b-30 small-dn" >
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="breadcome-list shadow-reset">
                                <div class="row">
                                    
                                    <div class="col-lg-6" id="result-Query">
                                        <?php if (isset($_SESSION['alert'])): ?>
                                            <?php foreach ($_SESSION['alert'] as $type => $message ):
                                                $class = 'alert alert-dismissable alert-'.$type;?>
                                                <div class='<?php echo $class; ?>'>
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true"> &times; </button>
                                                    <?php  echo $message; ?>
                                                </div>
                                            <?php endforeach; unset($_SESSION['alert']); ?>

                                        <?php endif; ?>
                                    </div>
                                   
                                    <div class="col-lg-6">
                                        <ul class="breadcome-menu">
                                            <li><a href="#">Accueil</a> <span class="bread-slash">/</span>
                                            </li>
                                            <li><span class="bread-blod">
                                                      <?php  if(isset($_GET['titre'])) {echo $_GET['titre'];}?>
                                                </span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end breadcumb desktop-->


<?php
     //$acces = '../pages/';
     if(isset($_GET["pages"])) $page = $_GET["pages"];
     else $page = "";

     switch ($page)
     {

         case "patients.php":
            require("../pages/patient/patients.php");
         break;

         case "domaine.php":
           require("../pages/patient/patients.php");
         break;

         case "facturation_et_encaissement.php":
             require("../pages/facturation/facturation_et_encaissement.php");
             break;

        case "list_medecin.php":
             require("../pages/medecin/list_medecin.php");
             break;



     }

 ?>


