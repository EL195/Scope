<div class="form-group" style="/*margin-top: 20px;*/">
    <div class="container-fluid">
        <div class="row">
            <div class="form-group col-lg-8 col-md-12 col-sm-12">
                <div class="sparkline8-list shadow-reset">
                    <div class="sparkline8-hd">
                        <div class="main-sparkline8-hd">
                            <h1>Facturation et Encaissement</h1>
                            <div class="sparkline8-outline-icon">
                                <span class="sparkline8-collapse-link"><i class="fa fa-chevron-up"></i></span>
                                <span><i class="fa fa-wrench"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="sparkline8-graph">
                        <?php  require_once('../pages/facturation/ihm/FacEnc.ihm.php'); ?>
                    </div>
                </div>
            </div>

            <div class="form-group col-lg-4 col-md-12 col-sm-12 ">
                <div class="sparkline9-list sparkel-pro-mg-t-30 shadow-reset">
                    <div class="sparkline9-hd">
                        <div class="main-sparkline9-hd">
                            <h1>Recette Journalière</h1>
                            <div class="sparkline9-outline-icon">
                                <span class="sparkline9-collapse-link"><i class="fa fa-chevron-up"></i></span>
                                <span><i class="fa fa-wrench"></i></span>
                                <span class="sparkline9-collapse-close"><i class="fa fa-times"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="sparkline9-graph">
                        <?php  require_once('../pages/recettes/recettes-journaliere/ihm/recettes-journaliere.ihm.php'); ?>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>










