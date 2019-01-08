

<%@page import="java.time.Year"%>
<%@page import="beans.Templates"%>
<%@page import="db_connections.WorkInDB"%>
 <% 
     String idtype = request.getParameter("idtype");
     String operation = request.getParameter("op");
    
     String req = "CALL CREATE_PATIENT('"+request.getParameter("codep")+"',"
                                      + "'"+request.getParameter("nomp").toUpperCase()+"',"
                                      + "'"+request.getParameter("prenomp").toUpperCase()+"',"
                                      + "'"+request.getParameter("datenaissancep")+"',"
                                      + "'"+request.getParameter("lieup")+"',"
                                      + "'"+request.getParameter("sexep")+"',"
                                       + "'"+request.getParameter("niveau")+"',"
                                      + "'"+request.getParameter("religion")+"',"
                                      + "'"+request.getParameter("ethniep")+"',"
                                      + "'"+request.getParameter("professionp")+"',"
                                      + "'"+request.getParameter("situationp")+"',"
                                      + "'"+request.getParameter("telp")+"',"
                                      + "'"+request.getParameter("emailp")+"',"
                                      + "'"+request.getParameter("nationalitep")+"',"
                                      + "'"+request.getParameter("paysp")+"',"
                                      + "'"+request.getParameter("quartierp")+"',"
                                      + "'"+request.getParameter("villep")+"',"
                                      + "'"+request.getParameter("persaprevp").toUpperCase()+"',"
                                      + "'"+request.getParameter("teleprevp")+"',"
                                      + "'"+request.getParameter("nomperep").toUpperCase()+"',"
                                      + "'"+request.getParameter("nommerep").toUpperCase()+"',"
                                      + "'"+request.getParameter("lieudecesp")+"',"
                                      + "'"+request.getParameter("datedecesp")+"',"
                                      + "'"+request.getParameter("heuredecesp")+"',"
                                      + ""+idtype+","+operation+")";
     
   
     if(new WorkInDB().Insert_Update_Delete(req)){
          String msg = "";
          int op = Integer.parseInt(operation);
     if(op == 1){
         msg = "ENREGISTREMENT DU PATIENT REUISSIE";
     }else if(op == 2){
         msg = "MODIFICATION DU PATIENT REUISSIE";
     }
          System.err.println(" op = "+operation+" mess = "+msg); 
         out.println(new Templates().getAlert("", msg, "alert-success"));
         String newcode ="PAT00T1"+new WorkInDB().getUniqueValue("select (count(CodePatient)+1)as max from PATIENT", "max")+Year.now().toString();
         String np = request.getParameter("nomp")+" "+request.getParameter("prenomp");
         String srp ="<script type='text/javascript'> "
                    + "$(function () {$('#CodePatient').val('"+newcode+"');"
                           + "$('#Facturation-Code_Patient').val('"+request.getParameter("codep")+"');"
                 + "$('#Facturation-Nom_Patient').val('"+np.toUpperCase()+"');"
                 + "$('#Facturation-Sexe_Patient').val('"+request.getParameter("sexep")+"');"
                 + "$('#form-create-patient').get(0).reset();"
                 + "$('#modal-creer-patient').modal('hide');"
                 + " $('#txt-op-patient').val('1');"
                 + " $('#head-modal-patient').text('NOUVEAU PATIENT');"
                 + " })(jQuery);"
                      + "</script> ";
         out.println(srp);
     } else{
        /* int n = request.getParameter("codep").length();
         String s = request.getParameter("codep").substring(0);
         out.println(new Templates().getAlert("", "n_send = "+n+" code_send = "+s, "alert-danger"));*/
         out.println(new Templates().getAlert("", "ECHEC AJOUT PATIENT"+" code="+request.getParameter("codep"), "alert-danger"));
     }
  %>

   
    
   <script type='text/javascript'> 


</script>
      
