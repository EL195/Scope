<form id="form-create-patient">

    <input type="hidden" value="1" id="txt-id-type-patient">
    <input type="hidden" value="1" id="txt-op-patient">
<div class="form-group sparkline10-list  shadow-reset">
    <div class="sparkline10-hd">
        <div class="main-sparkline10-hd">
            
            <h1>Etat Civil
               <div class=" btn-header btn-group btn-custom-groups btn-custom-groups-one btn-mg-b-10">
                    <button type="button" 
                            class="btn btn-success btn-operation-patient">
                        <span class="fa fa-check-circle-o"></span>
                        Valider
                    </button>
                   <button type="reset" 
                            class="btn btn-danger btn-reset-form-patient">
                        <span class="fa fa-ban"></span>
                        Annuler
                    </button>
                                       
                </div>
            </h1>
          
            <div class="sparkline10-outline-icon">
                <span class="sparkline10-collapse-link"><i class="fa fa-chevron-up"></i></span>
                
            </div>
        </div>
    </div>
    <div class="sparkline10-graph">
        <?php  require_once('../pages/patient/bloc-input/etat-civil.php'); ?>
    </div>
</div>

<div class="form-group sparkline11-list  shadow-reset">
    <div class="sparkline11-hd">
        <div class="main-sparkline11-hd">
             <h1>Localisation
               <div class=" btn-header btn-group btn-custom-groups btn-custom-groups-one btn-mg-b-10">
                    <button type="button" 
                            class="btn btn-success btn-operation-patient">
                        <span class="fa fa-check-circle-o"></span>
                        Valider
                    </button>
                   <button type="reset" 
                            class="btn btn-danger btn-reset-form-patient">
                        <span class="fa fa-ban"></span>
                        Annuler
                    </button>
                                       
                </div>
            </h1>
            <div class="sparkline11-outline-icon">
                <span class="sparkline11-collapse-link"><i class="fa fa-chevron-up"></i></span>
            </div>
        </div>
    </div>
    <div class="sparkline11-graph" style="display: none; text-align: left;">
        <?php  require_once('../pages/patient/bloc-input/localisation.php'); ?>
    </div>
</div


<div class="form-group sparkline12-list  shadow-reset">
    <div class="sparkline12-hd">
        <div class="main-sparkline12-hd">
             <h1>Contact
               <div class=" btn-header btn-group btn-custom-groups btn-custom-groups-one btn-mg-b-10">
                    <button type="button" 
                            class="btn btn-success btn-operation-patient">
                        <span class="fa fa-check-circle-o"></span>
                        Valider
                    </button>
                   <button type="reset" 
                            class="btn btn-danger btn-reset-form-patient">
                        <span class="fa fa-ban"></span>
                        Annuler
                    </button>
                                       
                </div>
            </h1>
            <div class="sparkline12-outline-icon">
                <span class="sparkline12-collapse-link"><i class="fa fa-chevron-up"></i></span>
            </div>
        </div>
    </div>
    <div class="sparkline12-graph" style="display: none ; text-align: left;">
        <?php  require_once('../pages/patient/bloc-input/contact.php'); ?>
    </div>
</div>
                       
</form>                   
                

 