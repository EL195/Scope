 function sendAjaxQuery(_data,_idz,_url,_method,_callback){
  //alert("data = "+_data+"\n url = "+_url+"\n idz = "+_idz+"\n method = "+_method);
    // _callback;
    $('#'+_idz).html('');
     $.ajax({
              url: _url,
              method: _method,
              data: _data,
              dataType: "text",
              error: function (jqXHR, textStatus, errorThrown) {
                    $(_idz).html('<center>' +
                        '<h1 style="width: auto; height: 50px; border: 2px solid #761c19; background: #dddddd;">' +
                        '<span>Veuillez Patienter ...</span><img src="../img/loading.gif" alt="Chargement"/>' +
                        '</h1>' +
                        '</center>');
               },

              success: function(data){
                   $('#'+_idz).html(data);
              }
            });
  }

  function getUrl(_filename){
    return '../modeles/'+_filename+'.php';
  }




 function ct(id_result) {
   /*  var _idz = id_result;
     var _url = getUrl('result-cout-total');
     var _method = 'post';
     var _data= {code:$("#Facturation-Code_Patient").val()}
     //  callback = {function(){searchacte();},function(){searchacte();getCoutTotal('Facturation-NetApayerGrand');}};
     sendAjaxQuery(_data,_idz,_url,_method);
     $(function () {
       /*  var f = new Intl.NumberFormat();
         $('#'+id_result).val( f.format( parseInt( $(this).val() )) );*/
    // });*/

     $('#'+id_result).val('0');

     // alert('Code patient select = '+$("#Facturation-Code_Patient").val());
     $.ajax({
         url: getUrl('result-cout-total'),
         method: "post",
         data: {code:$("#Facturation-Code_Patient").val()},
         dataType: "text",
         success: function(data){
             if(data === ''){
                 $('#'+id_result).val('0');

             }else {
                 var f = new Intl.NumberFormat();
                 $('#'+id_result).val(f.format( parseInt(data) ));
             }

         }
     });

 }

 function newModule(nomtable,colone,id_select){
           var titre = "AJOUTER "+nomtable+" DANS LA BASE DE DONNEES";
    // getTocombo(nomtable,colone,col_out,id_select);
      if(libelle = prompt(titre)) {
         // alert('vous avez saisie ' + libelle);
          var _url = getUrl('result-create-module');
          var _method = 'post';
          var _data = {
              "nom_table": nomtable,
              "colonne_out": colone,
              "id_out": colone,
              "valeur": libelle
          };
          callback = 0;
          sendAjaxQuery(_data, '#'+id_select, _url, _method, callback);
      }


}

     

     function getTocombo(_table,_col,_id_out,_idz){

         var _url = getUrl('result-create-module');
         var _method = 'post';
         var _data = { "nom_table":_table,
             "colonne_out":_col,"id_out":_id_out };
         callback = 0;
         sendAjaxQuery(_data,_idz,_url,_method,callback);


         //alert('table = '+table+' col = '+col+' id = '+id_z);

     }
     function executeCommande(data){

      /* alert("idacte = "+_idproduct+"\n qte = "+_qte+"\nmt = "+_mt+"\
                \nidpatient = "+_idpatient+"\n idresult  = "+_idresult);*/
         if($('#Facturation-Code_Patient').val()!==''){

            var _idz = 'result-add-commande-patient';
             var _url = getUrl('result-commande-operation');
             var _method = 'post';
           /*  var __data = {idproduct:_idproduct,
                 idpatient:_idpatient,
                 qtec:_qte,
                 action:_action,
                 mt:_mt};*/
          //  callback = {function(){searchacte();},function(){searchacte();getCoutTotal('Facturation-NetApayerGrand');}};
             sendAjaxQuery(data,_idz,_url,_method);

         }else if($('#Facturation-Code_Patient').val() === ''){
           alert("VEUILLEZ SELECTIONNER UN PATIENT");
       }
        
     }
     

     function saveCommande(){
      /* alert("idpratic = "+_idpraticien+"\n idservice = "+_idservice+"\nmt = "+_mt+"\
                \nidpatient = "+_idpatient+"\n idresult  = "+_idresult);*/
       
       if($('#Facturation-Code_Patient').val()!==''){
           $('#result-Query').html('');
         $.ajax({
                  url: "../sending-ajax/result-save-commande.jsp",
                  method: "post",
                  data: {idpraticien:$('#Facturation-Numero_praticien').val(),
                         idpa:$('#Facturation-Code_Patient').val(),
                         idservice:$('#Facturation-Numero_service').val(),
                         idtypecommande:$('#Facturation-TypeCommande').val(),
                         ct:$('#Facturation-NetApayerGrand').text(),
                         avance:$('#Facturation-MontantPercu').val(),
                         idtypereglement:1},
                  dataType: "text",
                  success: function(data){
                   $('#result-Query').html(data);

                  }
                });
       }else if($('#Facturation-Code_Patient').val() === ''){
           alert("VEUILLEZ SELECTIONNER UN PATIENT");
       }
        
     }
     
     
    function createPatient(_type,_op,_idtype){
        var _codep='';
        var _nomp='';
        var _prenomp='';
        var _datenaissancep='';
        var _sexep='';
        var _lieup='';
        var _lieudecesp ='';
        
        
        if (_type === 'o'){
             _codep = $('#CodePatient').val(); 
            _nomp = $('#NomPatient').val();
             _prenomp = $('#PrenomPatient').val();
             _datenaissancep = $('#DateNaissancePatient').val();
             _sexep = $('#SexePatient').val();
             _lieup = $('#LieuNaissancePatient').val();
             
        }else if (_type === 'm'){
            _codep = $('#CodeMort').val(); 
             _nomp = $('#NomMort').val();
             _prenomp = $('#PrenomMort').val();
             _datenaissancep = $('#DateNaissanceMort').val();
             _sexep = $('#SexeMort').val();
             _lieup = $('#LieuNaissanceMort').val();
             _lieudecesp = $('#LieuDecesMort').val();
        }
        
        
      if( _nomp !== "" && _codep !== "" ) {
         $('#result-Query').html('');
         $('#result-Query-menu-mobile').html('');
          /* alert('Nom = '+_nomp+' prenom = '+_prenomp+' code = '+_codep+'\n lieudeces = '+_lieudecesp
                   +'\n datedeces = '+$('#DateDecesMort').val()+' dtmasq = '+$('#DateNaissancePatient').val());*/
         $.ajax({
                  url: "../sending-ajax/result-create-patient.jsp",
                  method: "post",
                  data: {
                         codep: _codep,
                         nomp: _nomp,
                         prenomp: _prenomp,
                         datenaissancep:_datenaissancep,
                         lieup:_lieup,
                         lieudecesp:_lieudecesp,
                         datedecesp:$('#DateDecesMort').val(),
                         heuredecesp:$('#HeureDecesMort').val(),
                         sexep:_sexep,
                         
                         niveau:"Aucun",
                         situationp:$('#SituationMatrimoniale').val(),
                         professionp:$('#ProfessionPatient').val(),
                         ethniep:$('#EthniePatient').val(),
                         religion:$('#ReligionPatient').val(),
                         nationalitep:$('#NationalitePatient').val(),
                         paysp:$('#PaysPatient').val(),
                         villep:$('#VillePatient').val(),
                         quartierp:$('#QuartierPatient').val(),
                         telp:$('#TelephonePatient').val(),
                         persaprevp:$('#PersAprevPatient').val(),
                         teleprevp:$('#TelPersAprevPatient').val(),
                         emailp:$('#EmailPatient').val(),
                         nomperep:$('#NomPerePatient').val(),
                         nommerep:$('#NomMerePatient').val(),
                         idtype:_idtype,
                         op:_op
                         },
                  dataType: "text",
                  success: function(data){
                    $('#result-Query').html(data);
                    $('#result-Query-menu-mobile').html(data);
                    
                    $('#form-create-mort').get(0).reset(); 
                  }
                   
                });
      }else if( _nomp === "" ) {
          alert('VEUILLEZ SAISIR UN NOM');
      }

   }
   
   function placeValues(id_num,val_id_num,id_libele,val_id_libele,id_input){
        $(id_num).val(val_id_num);
        $(id_libele).val(val_id_libele);
        $(id_input).val('');
    }
 
    function getMontant(_id){
        
         var f = new Intl.NumberFormat();
       
        mt = parseInt($('#mt'+_id).val());
        mta = f.format($('#mt'+_id).val());
       
        qte = $('#qte'+_id).val();
        cout = parseInt($('#cout'+_id).val());
         $('#couta'+_id).text(f.format(cout));
        // alert("pu td = "+$('.td-pu').text());
        //alert('cout = '+cout+'\nqte = '+qte+'\nmt = '+mt);
        if (qte>0){
            
           parseInt($('#mt'+_id).val(qte *cout)); 
            $('#mta'+_id).text(f.format(parseInt($('#mt'+_id).val())));
            //alert('f = '+f.notformat(parseInt($('#mt'+_id).val())));
           
        }else{
           alert("VEUILLEZ SAISIR UNE VALEUR > 0");
           $('#qte'+_id).val(1);
          parseInt($('#mt'+_id).val(1 *cout)); 
        }
    }
     

     
     
     
     function getMenus(_module,_user,idresult){
        // alert('user = '+_user+' module = '+_module)
      //   $('#result-searching-menus').html('');
      $('#'+idresult).html('');
         $.ajax({
                  url: "../sending-ajax/result-searching-menus.jsp",
                  method: "post",
                  data: {IDuser:_user,
                        IDModule:_module},
                  dataType: "text",
                  success: function(data){
                   // $('#result-searching-menus').html(data);
                   $('#'+idresult).html(data);
                    
                  }
                });
             // alert('user = '+_user+' module = '+_module);   
             
     }
     
     
     function getPages(_page,_titre,_istxtSearch){
        // alert('page = '+_page+' titre = '+_titre);
      //   $('#result-searching-menus').html('');
      $('#menu-left').html('');
         $.ajax({
                  url: "../pages/servlet.php",
                  method: "post",
                  data: {pages:_page+'.jsp',
                        titre:_titre,
                    istxt:_istxtSearch},
                  dataType: "text",
                  success: function(data){
                    $('#menu-left').html(data);
                   
                  // $('#result-searching-menu-left').html(data);
                    
                  }
                });
             // alert('user = '+_user+' module = '+_module);   
             
     }
     
     $(document).ready(function (){
        // executeCommande({idpatient:$('#Facturation-Code_Patient').val()});
     // alert("date = ");
       // searchpatient('',$('#txt-action').val());
       searchacte();
       // refreshCombo();
        $('#entete-facture-patient').text('DETAILS COMMANDE DE : '+$('#Facturation-Nom_Patient').val());
        $(function (){
            $('#btn-afficher-acte').click(function (){
                goSearching('','', 'result-searching-acte.jsp',
                '#result-searching-acte',$('#Facturation-Nom_domaine').val());
            });
            
            
            $('.btn-operation-patient').click(function (){
               createPatient('o',$('#txt-op-patient').val(),$('#txt-id-type-patient').val());
            });
            
             $('.btn-reset-form-patient').click(function (){
               $('#form-create-patient').get(0).reset();
            });
            
            $('.module').click(function (){
               $('#result-searching-menus').hide("slow",3000);
            });

            $('#btn-creer-patient').click(function (){
                createPatient();
            });

            $('#LibelleActe').on('input',function (){
               searchacte();        
            });
            $('.td-add-commande').on('click',function (){
                //alert('fgdgc');

                        
            });
            
            $('.modules').on('click',function (){
               // alert(' val = '+$(this).val());
                getMenus($(this).val(),1,'result-searching-menus');
             
            });
            
             $('#btn-search-patient-facturation').on('click',function (){
                $('#txt-action').val('0');
                 var act =  $('#txt-action').val();
                searchpatient('',act);
             
            });
            
            $('.btn-refresh-list-patient').on('click',function (){
              
                 var act =  $('#txt-action').val();
                searchpatient($('#NomPatientSearch').val(),act);
             
            });
            
            $('#btn-nouveau-patient').on('click',function (){
                 $('#form-create-patient').get(0).reset();
                  $('#head-modal-patient').text('NOUVEAU PATIENT');
            });
            
            $('#Facturation-ID_Domaine').on('change',function (){
               searchacte();
            });
           
          $('#NomPatientSearch').on('input',function (){
                searchpatient($('#NomPatientSearch').val(),$('#txt-action').val());
            });
            
             
            
            $('#btn-search-service').on('click',function (){
                goSearching('service',$('#LibelleService').val(),
                'sending-ajax/result-searching.jsp','#result-searching');
            });
            
            $('#btn-search-patient').on('click',function (){
              goSearchingPatient($('#NomPatientSearch').val());
            });
            
            $('#btn-actualiser-facture-hospitalisatisation').on('click',function (){
                executeCommande({idpatient:$('#Facturation-Code_Patient').val()});
                ct('Facturation-NetApayerGrand');
            });
            
            $('#LibelleActe').on('change',function (){
              
            });
            
            $('.checkbox-TypeCommande').on('click',function (){
               //isChecked($(this).attr('id'));
               $('#Facturation-TypeCommande').val($(this).val());
               //alert(" id = "+$(this).attr('id')+' val = '+$('#Facturation-TypeCommande').val());
               
            });
            
            $('#Facturation-MontantPercu').on('input',function (){
              $('#Facturation-Relicat').val($(this).val()-$('#Facturation-NetApayerGrand').val());
            });
            
            $('#btn-enregistrer-facture').on('click',function (){
               /*saveCommande('idPra' , $('#Facturation-Numero_service').val() , 'typerelement',
               $('#Facturation-Code_Patient').val() , 'result-save-commande' );*/
                 saveCommande();
                
            });
        });
        
        
       
    });
    
    function filltxtFormPatient(_code,_nom,_prenom,_naiss,_lieunaiss,
    _sexe,_niveau,_religion,_ethnie,_prof,_addre,_tel,_mail,_nationalite,
    _pays,_quartier,_ville,_persprev,_telpersprev,_pere,_mere){
        $('#head-nouveau-modifier-patient').text('MODIFIER PATIENT');
        $('#CodePatient').val(_code);
        $('#NomPatient').val(_nom);
        $('#PrenomPatient').val(_prenom);
        $('#DateNaissancePatient').val(_naiss);
        $('#LieuNaissancePatient').val(_lieunaiss); 
        $('#SexePatient').val(_sexe);
        //$('#NiveauPatient').val(_niveau);
         $('#ReligionPatient').val(_religion);
         $('#EthniePatient').val(_ethnie);
         $('#ProfessionPatient').val(_prof);
         // $('#AdressePatient').val(_addre);
         $('#TelephonePatient').val(_tel);
         $('#EmailPatient').val(_mail);
         $('#NationalitePatient').val(_nationalite);
         $('#PaysPatient').val(_pays);
         $('#QuartierPatient').val(_quartier);
         $('#VillePatient').val(_ville);
         $('#PersAprevPatient').val(_persprev);
         $('#TelPersAprevPatient').val(_telpersprev);
         $('#NomPerePatient').val(_pere);
         $('#NomMerePatient').val(_mere);
          
        
    }
  function searchpatient(name,_action){
        var _idz = "result-searching-patient";
                var _url = getUrl('result-searching-patient.jsp');
                var _method = 'post';
                var _data = {"nompatient":name ,"action":_action };
                callback = 0;
              sendAjaxQuery(_data,_idz,_url,_method,callback);
  } 
  
  
  function searchacte(){
      // function searchacte(_acte,_patient,_domaine){
   // alert('domaine = '+$('#Facturation-ID_Domaine').val());
                var _idz = "result-searching-acte";
                var _url = getUrl('result-searching-acte');
                var _method = 'post';
                var _data = {  "NomActe":$('#LibelleActe').val() ,
                    "CodePatient":$('#Facturation-Code_Patient').val() ,
                    "IDDomaine":$('#Facturation-ID_Domaine').val() };
                //var _data = {  "NomActe":_acte , "CodePatient":_patient , "IDDomaine":_domaine };
                callback = 0;
              sendAjaxQuery(_data,_idz,_url,_method,callback);
  } 
  
  function  goSearching(nomtable,val,lien,id_r ,val_select){
        //alert("lien = "+lien+"\n table = "+nomtable+"\n val = "+val+"\nid_result = "+id_r+"\n nomdomaine = "+val_select);
      
     
        var _idz = "result-searching-patient";
                var _url = getUrl('result-searching-acte.jsp');
                var _method = 'post';
                var _data = {  "libelle_val":val , "table_name":nomtable, "select":val_select , "idpa":$("#Facturation-Code_Patient").val() };
                callback = 0;
              sendAjaxQuery(_data,_idz,_url,_method,callback);
  }  
    
  

    
    
    
    
    function  isChecked(id_s){
        
         /* $('#check-Ordinaire' ,'#check-Accord_remise','#check-Tier_Payant','#check-Prise_en_Charge').each(function (){
               
                    if  ($(this).attr('id') === id_s){
                        alert('yes');
                         if($('#'+$(this).attr('id')).is(':checked')===true){
                             $(this).prop('checked',false);
                         }else{ $(this).prop('checked',true);}
                         
                    }else{
                         $(this).prop('checked',false);
                    };      
              });
        var e = '[id="'+id_s+'"]';
        
         $(e).click(function (){
             // alert('val id  = '+$(this).attr('id'));
            $(e).attr('checked',false);
            $(this).attr('checked', !$(this).attr('checked'));
        });*/
      
    }
    (function () {
       var e = 'radio[@name='+'check-Accord_remise'+']';
        //alert(" id = "+e);
        
     })(jQuery);
     
     
     