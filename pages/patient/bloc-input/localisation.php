
<div class="row form-group">
    
    <div class="form-group col-sm-12">
       <span class="txt1">PAYS :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="PaysPatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM pays",
                    'NomPays','NomPays'); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('PAYS','NomPays','PaysPatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div> 
    <div class="form-group col-sm-12">
       <span class="txt1">VILLE  :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="VillePatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM ville",
                    'NomVille','NomVille'); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('VILLE','NomVille','VillePatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div> 
   
        <div class="form-group col-sm-12">
       <span class="txt1">QUARTIER :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="QuartierPatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM quartier",
                    'NomQuartier','NomQuartier'); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('QUARTIER','NomQuartier','QuartierPatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div>      
                   
                   
</div>
    
              