
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12 inline-basic-form">
                  <div class="form-group  basic-login-inner inline-basic-form">
                    <div class="form-group-inner">
                        <div class="row">
                            <div class="form-group col-sm-12 col-lg-6 col-md-6 col-xs-12">
                                <span class="txt1">FILTRER SUR DOMAINE:</span>
                                 <div style="/*display: none;*/" id="result-Num_domaine"> </div>
                                <div class="wrap-input100">
                                <select class="input100 " id='Facturation-ID_Domaine' >
                                    <?php echo $db->getColumnToCombo("SELECT * FROM domaine",'NomDomaine','IDDomaine'); ?>

                                </select>
                                <span class="focus-input100"></span>
                             </div>
                           </div>
                            <div class=" form-group col-lg-6 col-sm-12 col-md-6 col-xs-12">
                                <span class="txt1" style="opacity: 0;">FILTRER SUR DOMAINE:</span>
                                     <div class="wrap-input100 input-group">
                                    <input class="input100" 
                                          id='LibelleActe'
                                          placeholder ="Nom de l'Acte"
                                           type="text">
                                    <span class="focus-input100"></span>
                                    <span class="input-group-btn"> 
                                        <button type="button"
                                                title="rechercher"
                                                class="btn btn-search-acte btn-default">
                                            <span class="fa fa-search"></span>
                                        </button>
                                       
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
  <div class="col-lg-12 col-md-12 col-sm-12  col-xs-12 form-group" id="" >
           <div class="form-group table-scrolable">
            <input type="hidden" id="txt-action" value="1">
               <div  id="result-searching-acte">
                   
                </div>
                
            </div>
        </div>
    </div>
 </div>
        
        
        <script>
            
        </script>