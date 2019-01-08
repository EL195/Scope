
<!-- ============MODAL IHM PATIENT======================================================================-->
<div class="modal fade " id="modal-creer-patient" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1 ">
                <h4 id="head-modal-patient" class="modal-title">NOUVEAU PATIENT</h4>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#">
                        <i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
                <?php  require('../pages/patient/ihm/patient.ihm.php'); ?>
            </div>

        </div><!-- /.modal-dialog -->
    </div>
</div>
<!-- ============/////////////////////=====================================================================-->


<!-- ============MODAL IHM MEDECIN======================================================================-->
<div class="modal fade " id="modal-creer-medecin" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1 ">
                <h4 id="head-modal-patient" class="modal-title">NOUVEAU MEDECIN</h4>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#">
                        <i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
                <?php  require('../pages/medecin/ihm/medecin.ihm.php'); ?>
            </div>

        </div><!-- /.modal-dialog -->
    </div>
</div>
<!-- ============/////////////////////=====================================================================-->







<!-- ============MODAL IHM LIST PATIENT======================================================================-->
<div class="modal fade " id="modal-search-patient" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1 ">
                <h4 class="modal-title">RECHERCHER PATIENT</h4>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#">
                        <i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
                <?php  require('../pages/patient/ihm/liste-patients.ihm.php'); ?>
            </div>

        </div><!-- /.modal-conten -->
    </div>
</div>
<!-- ============/////////////////////=====================================================================-->


<!-- ============MODAL IHM LIST SERVICE======================================================================-->
<div class="modal fade " id="modal-search-service" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md ">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1 ">
                <h4 class="modal-title">RECHERCHER SERVICE</h4>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#">
                        <i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
                <?php  require('../pages/service/ihm/search-service.ihm.php'); ?>
            </div>

        </div><!-- /.modal-content -->
    </div>
</div>
<!-- ============/////////////////////=====================================================================-->



<!-- ============MODAL IHM LIST ACTE======================================================================-->
<div class="modal fade " id="modal-search-acte" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1 ">
                <h4 class="modal-title">CHOISIR LES ACTES</h4>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#">
                        <i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
                <?php  require_once('../pages/acte/ihm/search-acte.ihm.php'); ?>
            </div>

        </div><!-- /.modal-conten -->
    </div>
</div>
<!-- ============/////////////////////=====================================================================-->

<!-- ============MODAL IHM PATIENT======================================================================-->

<!-- ============/////////////////////=====================================================================-->