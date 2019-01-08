<%@page import="db_connections.WorkInDB"%>
<div class="row form-group">
    <div class="col-sm-6">
        <span class="txt1">CODE :</span>
        <div class="wrap-input100">
            <input class="input100" type="text" 
                   name="NomPatient"
                   id="CodeMort"
                   value="<% out.println("PAT00AB"+new WorkInDB().getUniqueValue("select (count(CodePatient)+1)as max from PATIENT", "max")+"2018"); %>"
                   disabled="true"
                   placeholder="Automatique">
            <span class="focus-input100"></span>
        </div>
    </div>
</div>
<div class="row form-group">
    <div class="col-sm-6">
        <span class="txt1">NOM :</span>
        <div class="wrap-input100">
            <input class="input100" type="text" 
                   required="true"
                    id="NomMort">
            <span class="focus-input100"></span>
        </div>
    </div>
    <div class="col-sm-6">
        <span class="txt1">PRENOM :</span>
        <div class="wrap-input100">
            <input class="input100" 
                   type="text" 
                   id="PrenomMort">
            <span class="focus-input100"></span>
        </div>
    </div>
</div>


<div class="row form-group">
    <div class="col-sm-2">
        <span class="txt1">SEXE:</span>
         <div class="wrap-input100">
             <select class="input100" 
                     id="SexeMort">			
               <option>M</option>
               <option>F</option>
             </select>
             <span class="focus-input100"></span>
         </div>
     </div>
   <div class="col-sm-3">
        <span class="txt1">NE(E) LE :</span>
        <div class="wrap-input100">
            <input class="input100" 
                   type="date" 
                   id="DateNaissanceMort">
            <span class="focus-input100"></span>
        </div>
    </div>
    <div class="col-sm-5">
       <span class="txt1">A :</span>
        <div class="wrap-input100">
           <select class="input100" id="LieuNaissanceMort">			
            </select>
            <span class="focus-input100"></span>
        </div>
    </div>
    <div class="col-sm-2 newmodule">
         <button type="button" class="btn btn-default btn-add btn-outline-success"
                onclick="newModule('VILLE','NomVille','LieuNaissanceMort');">
            <img src='images/icones/ajouter_standard.png'>
        </button>  
    </div>
</div>

<div class="row form-group">
   <div class="col-sm-3">
        <span class="txt1">DECEDE(E) LE :</span>
        <div class="wrap-input100">
            <input class="input100"
                   type="date" 
                   id="DateDecesMort"
                   name="NomMort">
            <span class="focus-input100"></span>
        </div>
    </div>
    <div class="col-sm-3">
        <span class="txt1">A :</span>
        <div class="wrap-input100">
            <input class="input100"
                   type="time" 
                   id="HeureDecesMort">
            <span class="focus-input100"></span>
        </div>
    </div>
    <div class="col-sm-6">
         <span class="txt1">LIEU DE DECES :</span>
        <div class="wrap-input100">
            <input class="input100" 
                   type="text" 
                   id="LieuDecesMort">
            <span class="focus-input100"></span>
        </div>
        
    </div>
 </div>
