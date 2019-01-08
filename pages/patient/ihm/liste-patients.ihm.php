 <div class="container-fluid">
    <div class="row">
        <div class="col-lg-12 inline-basic-form">

                 <div class="floatleft  form-group">
                     <!--<div class="wrap-input100">
                        <select class="input100" name="GroupNomPatient">			
                          <option>NOM PATIENT</option>
                          <option>CODE PATIENT</option>
                        </select>
                        <span class="focus-input100"></span>
                    </div>-->
                 </div>
                  <div class="form-group  basic-login-inner inline-basic-form">
                    <div class="form-group-inner">
                        <div class="row">
                            <div class=" form-group  col-lg-8 col-sm-12 col-md-6 col-xs-12">
                                
                                     <div class="wrap-input100 input-group">
                                    <input class="input100" 
                                           placeholder="Nom du Patient" 
                                           id="NomPatientSearch" 
                                           type="text">
                                    <span class="focus-input100"></span>
                                    <span class="input-group-btn"> 
                                        <button type="button"
                                                title="rechercher"
                                                class="btn btn-search-patient btn-default">
                                            <span class="fa fa-search"></span>
                                        </button>
                                        <button type="button"
                                                title="actualiser"
                                                class="btn btn-refresh-list-patient btn-default">
                                            <span class="fa fa-refresh"></span>
                                        </button>
                                        
                                         <button type="button"
                                                title="nouveau"
                                                id="btn-nouveau-patient"
                                                data-toggle="modal" 
                                                data-target="#modal-creer-patient"
                                                class="btn  btn-primary">
                                            <span class="fa fa-plus-square-o"></span>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <div class="col-lg-12 col-md-12 col-sm-12  col-xs-12 form-group" >
            <div class="form-group table-scrolable">
                <input type="hidden" id="txt-action" value="1">
                <div id="result-earching-patient"></div>
            </div>
        </div>
    </div>
 </div>
        
        
        <script>
             $(function (){
                 $('#btn-nouveau-patient').click(function (){

                });
                
                 $('.input100').on('input',function (){
                  
                });
             });
        </script>