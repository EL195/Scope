<div class="form-group  row">
       <div class="col-lg-12 col-sm-6 col-md-6 col-xs-12">
            <div class="wrap-input100 input-group input-mark-inner mg-b-22">
                <span class="input-group-addon txt1">DATE :</span>
                <input class="form-control" type="text" 
                       id="RJ-DateFacture"
                       data-mask="99/99/9999" 
                       readonly="true"
                       disabled="true"
                       value=""
                       required="true"/>
                <span class="focus-input100"></span>
            </div>                     
                                    
        </div>   
    
    <div class="form-group-4   col-lg-12 col-sm-6 col-md-6 col-xs-12">
          <div class="wrap-input100 input-group">
            <input class="input100" 
                   placeholder="Nom du Patient" 
                   id="RJ-NomPatientSearch" 
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
            </span>
        </div>               
                                    
     </div>   
 </div>

 <div class="form-group row">
     <div class="table-scrolable" id="result-searching-RJ">
         <table class="table table-striped table-bordered table-responsive"> 
         <thead> 
             <tr> 
                 <th>CodeFacture</th>
                 <th>Nom Complet</th> 
                 <th>Montant</th>
                 <th>Action</th>
             </tr> 
         </thead> 
         <tbody> 
             <tr> 
                 <td>Tanmay</td> 
                 <td>Bangalore</td>
                 <td>560001</td>
                 <td>560001</td>
             </tr> 
           
         </tbody> 
     </table> 
       
     </div>
       <div class="row form-group">
            <div class="col-lg-12 col-sm-6 col-md-6 col-xs-12">
                    <div class="wrap-input100 input-group">
                        <span class="input-group-addon txt1">RECETTE :</span>
                        <span class="form-control txt-montant-lg txt-montant-lg_y" 
                               id="RJ-MontantTotal">
                            120 000 000<small> Fcfa</small>
                        </span>
                    </div>                     
            </div> 
    </div>
 </div>

