<div class="form-group form-group-4 user-profile-about shadow-reset">
    <div class="row">
        <div class="col-lg-6  col-sm-6 col-md-12 col-xs-12 form-group">
            <span class="txt1">Code facture:</span>
            <div class="wrap-input100">
                <input class="input100" type="text"
                       id="Facturation-Code_Facture"
                       placeholder="Automatique"
                       disabled="true">
            </div>
        </div>
        <div class="col-lg-6  col-sm-6 col-md-12 col-xs-12">
            <span class="txt1">Date facture:</span>
            <div class="wrap-input100">
                <input class="input100" type="text"
                       id="Facturation-DateFacture"
                       disabled="true">
            </div>
        </div>
    </div>

</div>



<div class="form-group  shadow-reset  user-profile-about">
    <h2>PATIENT</h2>
    <div class="row">

        <div class="row form-group">
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                <div class="i-checks">
                    <label>
                        <div  class="iradio_square-green">
                            <input value="1"
                                   checked="true"
                                   name="a"
                                   class="group-radio"
                                   type="radio">
                            <ins  class="iCheck-helper"></ins>
                        </div>
                        Ordinaire
                    </label>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                <div class="i-checks">
                    <label>
                        <div  class="iradio_square-green">
                            <input value="2"
                                   name="a"
                                   class="group-radio"
                                   type="radio">
                            <ins  class="iCheck-helper"></ins>
                        </div>
                        Accord Remise
                    </label>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                <div class="i-checks">
                    <label>
                        <div  class="iradio_square-green">
                            <input value="3"
                                   name="a"
                                   class="group-radio"
                                   type="radio">
                            <ins  class="iCheck-helper"></ins>
                        </div>
                        Tiers Payants
                    </label>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                <div class="i-checks">
                    <label>
                        <div  class="iradio_square-green">
                            <input value="4"
                                   name="a"
                                   class="group-radio"
                                   type="radio">
                            <ins  class="iCheck-helper"></ins>
                        </div>
                        Prise En Charge
                    </label>
                </div>
            </div>
        </div>
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
                                                 data-target="#modal-creer-patient"
                                                 class="btn  btn-info">
                                            <i class="fa fa-plus-square-o"></i>
                                        </button>
                                    </span>
                </div>

            </div>
            <div class="col-lg-6 col-sm-12 col-md-7 col-xs-12 form-group">
                <span class="txt1">CODE PATIENT:</span>
                <div class="wrap-input100">
                    <input class="input100" type="text"
                           id="Facturation-Code_Patient"
                           disabled="true"
                           value="PAT00AB22018">
                    <span class="focus-input100"></span>
                </div>
            </div>
            <div class="col-lg-4 col-sm-6 col-md-3  col-xs-12 form-group">
                <span class="txt1">DATE DE NAISSSANCE:</span>
                <div class="wrap-input100">
                    <input class="input100"
                           type="text"
                           id="Facturation-Naissance_Patient"
                           disabled="true">
                    <span class="focus-input100"></span>
                </div>
            </div>


            <div class="col-lg-2 col-sm-6 col-md-2 col-xs-12">
                <span class="txt1">SEXE:</span>
                <div class="wrap-input100">
                    <input class="input100" type="text"
                           id="Facturation-Sexe_Patient"
                           disabled="true">
                    <span class="focus-input100"></span>
                </div>
            </div>
        </div>

    </div>

</div>


<div class="row">

    <div class=" form-group  col-lg-6 col-md-6 col-sm-12">
        <div class="shadow-reset user-profile-about" >
            <div class="form-group-4">
                <span class="txt1">PRATICIEN</span>
                <div class="input-group">
                    <span class="input-group-addon txt-id-select" id="Facturation-Numero_praticien">ID</span>
                    <input type="text"
                           class="form-control txt-select-val"
                           id="Facturation-Nom_Praticien"
                           readonly="true">
                    <span class="input-group-addon btn btn-primary"
                          data-toggle="modal"
                          data-target="#modal-creer-patient">
                      <i class="fa fa-search"></i>
                 </span>
                </div>
            </div>
        </div>
    </div>
    <div class=" form-group  col-lg-6 col-md-6 col-sm-12">
        <div class="shadow-reset user-profile-about" >
            <div class="form-group-4">
                <span class="txt1">PRESCRIPTEUR</span>
                <div class="input-group">
                    <span class="input-group-addon txt-id-select" id="Facturation-Numero_prescripteur">ID</span>
                    <input type="text"
                           class="form-control txt-select-val"
                           id="Facturation-Nom_Prescripteur"
                           readonly="true">
                    <span class="input-group-addon btn btn-primary"
                          data-toggle="modal"
                          data-target="#modal-search-acte">
                     <i class="fa fa-search"></i>
                </span>
                </div>
            </div>
        </div>
    </div>

</div>



<div class="form-group  shadow-reset  user-profile-about">
    <div class="row form-group">
        <div class="form-group-4">
            <span class="txt1">SERVICE</span>
            <div class="input-group">
                <span class="input-group-addon txt-id-select" id="Facturation-Numero_service">ID</span>
                <input type="text"
                       class="form-control txt-select-val"
                       readonly="true">
                <span class="input-group-addon btn btn-primary"
                      data-toggle="modal"
                      data-target="#modal-search-service"
                      id="Facturation-Nom_Service">
                     <i class="fa fa-search"></i>
                </span>
            </div>
        </div>
    </div>
    <div class="row form-group">
        <div class="form-group-4">
            <span class="txt1">cout total de la commande :</span>
            <div class="input-group">
                 <span class="btn btn-primary input-group-addon"
                       data-toggle="modal"
                       data-target="#modal-search-acte"
                       title="ajouter des actes a la commande">
                      <i class="fa fa-newspaper-o"></i>

                   </span>
                <span class="btn btn-warning input-group-addon"
                      title="actualiser la liste de la commande"
                      id="btn-actualiser-facture-hospitalisatisation">
                     <i class="fa fa-refresh"></i>

                </span>
                <input type="text"
                       id="Facturation-NetApayerGrand"
                       value="0"
                       style="background: #ffff00;"
                       class="input100  txt-montant-lg_g txt-montant-lg">
                <span class="input-group-addon txt1">F cfa</span>
            </div>
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


<div class="row">

    <div class=" form-group  col-lg-6 col-md-6 col-sm-12">
        <div class="shadow-reset user-profile-about" >
            <div class="row ">
                <div class="form-group-4 col-lg-12 col-md-12 col-sm-12 col-xs-12 form-group">
                    <span class="txt1">montant percus :</span>
                    <div class="input-group wrap-input100">
                        <input type="number"
                               id="Facturation-MontantPercu"
                               value="0"
                               style="background: #0B792F; color: #dddddd;"
                               class="input100  txt-montant-lg_g txt-montant-lg">
                        <span class="input-group-addon txt1">F cfa</span>
                    </div>
                </div>

                <div class="form-group-4  col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <span class="txt1">relicat :</span>
                    <div class="input-group wrap-input100">
                        <input type="text"
                               id="Facturation-Relicat"
                               value="0"
                               style="background: #761c19; color: #dddddd;"
                               class="input100 txt-montant-lg_g txt-montant-lg"
                               readonly="true">
                        <span class="input-group-addon txt1">F cfa</span>
                    </div>
                </div>
            </div>


        </div>
    </div>
    <div class=" form-group  col-lg-6 col-md-6 col-sm-12">
        <div class="shadow-reset user-profile-about" >
           <div class="row">
               <div class="form-group-4 col-lg-6 col-sm-12 col-md-6 col-xs-12 form-group">
                   <span class="txt1">REMISE:</span>
                   <div class="wrap-input100">
                       <input class="input100" type="text"
                              name="Facturation-remise"
                              id="Facturation-remise"
                              readonly="true"
                              disabled="true"
                              value="0,00%"/>
                       <span class="focus-input100"></span>
                   </div>
               </div>
               <div class="form-group-4 col-lg-6 col-sm-12 col-md-6 col-xs-12 form-group">
                   <span class="txt1">TICKET MODERATEUR:</span>
                   <div class="wrap-input100">
                       <input class="input100" type="text"
                              name="Facturation-ticket_moderateur"
                              id="Facturation-ticket_moderateur"
                              readonly="true"
                              disabled="true"
                              value="0,00%"/>
                       <span class="focus-input100"></span>
                   </div>
               </div>
               <div class=" form-group-4 col-lg-12 col-sm-12 col-md-12 col-xs-12 ">
                   <span class="txt1">MODE DE REGLEMENT:</span>
                   <div class="wrap-input100">
                       <select class="input100" name="ModeReglement">
                           <option>Comptant</option>
                       </select>
                       <span class="focus-input100"></span>
                   </div>
               </div>
           </div>
        </div>
    </div>

</div>



<div class="form-group user-profile-about shadow-reset">
    <div class="row">
       <div class="pull-right">
           <div class="form-group col-lg-6 col-md-6 col-sm-6">
               <button class="btn btn-success "
                       title="actualiser la liste de la commande"
                       id="btn-enregistrer-facture">
                   <i class="fa fa-check-circle-o"></i>
                   Valider
               </button>
           </div>
           <div class=" col-lg-6 col-md-6 col-sm-6">
               <button class="btn btn-danger "
                       type="reset"
                       title="Supprimer La commande de ce patient"
                       id="btn-enregistrer-facture">
                   <i class="fa fa-ban"></i>
                   Annuler
               </button>
           </div>
       </div>

    </div>
</div>


<div class="form-group  shadow-reset  user-profile-about">
    <div class="row">
        <div class=" col-lg-4 col-md-4 col-sm-4">

        </div>
        <div class="col-lg-4 col-md-4 col-sm-4">

        </div>
    </div>
</div>


<div class="form-group  shadow-reset  user-profile-about">
    <div class="row">

    </div>
</div>










