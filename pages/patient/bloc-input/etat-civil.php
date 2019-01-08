

<div class="container-fluid">
    <div class="row">
    <div class="col-sm-12 form-group">
        <span class="txt1">CODE PATIENT:</span>
        <div class="wrap-input100">
            <input class="input100" type="text" 
                   id="CodePatient"          
                   disabled="true"
                   placeholder="Automatique">
            <span class="focus-input100"></span>
        </div>
    </div> 
    </div>
    <div class="row ">
        <div class="form-group col-sm-6">
         <span class="txt1">NOM:</span>
         <div class="wrap-input100">
             <input class="input100" type="text" 
                    name="NomPatient"
                    id="NomPatient"
                    required="true">
             <span class="focus-input100"></span>
         </div>
     </div>
     <div class="form-group col-sm-6">
         <span class="txt1">PRENOM:</span>
         <div class="wrap-input100">
             <input class="input100" 
                    type="text" 
                    id="PrenomPatient"
                    name="PrenomPatient">
             <span class="focus-input100"></span>
         </div>
     </div>
    </div>
    <div class="row">
        <div class="form-group col-sm-6">
            <span class="txt1">NE(E) LE :<small style="margin-left: 10px;">jj/mm/yy</small></span>
            <div class="input-mark-inner  wrap-input100">
                 <input class="input100" 
                        data-mask="99/99/9999" 
                        type="text"
                        id='DateNaissancePatient'>
                 <span class="focus-input100"></span>
             </div>
        </div>
         <div class="form-group col-sm-6">
       <span class="txt1">A :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="LieuNaissancePatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM ville",'NomVille','NomVille',null); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('VILLE','NomVille','LieuNaissancePatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div>
    </div>
                   
    <div class="row">
       <div class=" form-group col-sm-6">
           <span class="txt1">SEXE:</span>
            <div class="wrap-input100">
                <select class="input100" 
                        id="SexePatient">			
                  <option>M</option>
                  <option>F</option>
                </select>
                <span class="focus-input100"></span>
            </div>
        </div>
        <div class=" form-group col-sm-6">
           <span class="txt1">SITUATION MATRIMONIALE:</span>
            <div class="wrap-input100">
                <select class="input100" id="SituationMatrimoniale">			
                  <option>Aucune</option>
                  <option>Célibataire</option>
                  <option>Divorcé(e)</option>
                  <option>Marié(e)</option>
                  <option>Veu(f)(ve)</option>
                </select>
                <span class="focus-input100"></span>
            </div>
        </div>
                
    </div>               
  
    <div class="row">
    
    <div class="form-group col-sm-6">
       <span class="txt1">PROFESSION :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="ProfessionPatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM profession",
                    'NomProfession','NomProfession'); ?>

            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('PROFESSION','NomProfession','ProfessionPatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div>
        <div class="form-group col-sm-6">
       <span class="txt1">ETHNIE :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="EthniePatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM ethnie",
                    'NomEthnie','NomEthnie'); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('ETHNIE','NomEthnie','EthniePatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div>                          
</div>
    
    
       <div class="row">
    
    <div class="form-group col-sm-6">
       <span class="txt1">RELIGION :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="ReligionPatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM religion",
                    'NomReligion','NomReligion'); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('RELIGION','NomReligion','ReligionPatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div>
        <div class="form-group col-sm-6">
       <span class="txt1">NATIONALITE :</span>
        <div class="input-group wrap-input100"> 
            <select class="input100" id="NationalitePatient">
                <?php echo $db->getColumnToCombo("SELECT * FROM nationalite",
                    'NomNationalite','NomNationalite'); ?>
            </select>
             <span class="focus-input100"></span>
             <span class="input-group-btn">
                 <button class="btn btn-primary newmodule"
                         onclick="newModule('Nationalite','NomNationalite','NationalitePatient');"
                         type="button"> 
                       <span class="fa fa-plus-square"></span>
                        
                 </button> 
             </span>
             
         </div>
    </div>                          
            
                   
                   
                   
                   
</div>
    
        <!-- /input-group              
   <!-- <div class="form-group col-sm-6 data-custon-pick" id="data_3">
            <span class="txt1">NEE LE:</span>
            <div class="input-group date">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                <input type="date" class="form-control">
            </div>
        </div>   -->             