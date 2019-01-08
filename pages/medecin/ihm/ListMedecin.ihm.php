



<div class="form-group  shadow-reset  user-profile-about">
    <h2>Rechercher un médécin</h2>
    <div class="row">
        <div class="row form-group-4">
            <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12 form-group">
                <span class="txt1">NOM COMPLET:</span>
                <div class="wrap-input100 input-group">
                    <input class="input100"
                           disabled
                           id="Facturation-Nom_Patient"
                           type="text">
                    <span class="input-group-btn">
                                        <button type="button"
                                                title="rechercher"
                                                data-toggle="modal"
                                                data-target="#modal-search-patient"
                                                class="btn btn-search-patient btn-default">
                                            <i class="fa fa-search"></i>
                                        </button>
                                         <button type="button"
                                                 title="nouveau"
                                                 id="btn-nouveau-patient"
                                                 data-toggle="modal"
                                                 data-target="#modal-creer-medecin"
                                                 class="btn  btn-info">
                                            <i class="fa fa-plus-square-o"></i>
                                        </button>
                                    </span>
                </div>

            </div>
        </div>

    </div>

</div>






<div class="form-group  shadow-reset  user-profile-about">
   
    <div class="row form-group">
        <div class="form-group-4">
            <span class="txt1">Tous les médécins</span>
            
        </div>
    </div>

    <div class="row" id='result-searching'>
        <div   style="overflow-y: scroll; height: 200px;" >
            <table class="table table-bordered table-condensed table-striped">
                <thead class="tr-entete-table">
                <tr>
                    <th>CodeActe</th>
                    <th>Libellé</th>
                    <th>Cout</th>
                    <th>Quantité</th>
                    <th>Montant</th>
                    <th>Remise</th>
                    <th>Action</th>
                </tr>
                </thead >
                <tbody id="result-add-commande-patient">

                </tbody>
            </table>
        </div>
    </div>

</div>


    


















