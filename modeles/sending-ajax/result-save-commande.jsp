

<%@page import="java.lang.Exception"%>
<%@page import="beans.Templates"%>
<%@page import="db_connections.WorkInDB"%>
 <%   
     
     
        String idservice = "0";
        String idpraticien = "0";
        
        try{
            if( !request.getParameter("idpraticien").equals("") ){
            idpraticien = request.getParameter("idpraticien");
           
          }
          if( !request.getParameter("idservice").equals("") ){
            idservice = request.getParameter("idservice");
          }
        }catch(Exception e){
          System.err.println("erreur de transtiapge :"+e);
        }
        
          String avance = request.getParameter("avance");
          String req ="";
          String rq ="CALL COUT_TOTAL_COMMANDE_TEMP_D_UN_PATIENT('"+request.getParameter("idpa")+"',1)";
      String  r  = new WorkInDB().getUniqueValue(rq, "CT");
              String rq_index = "CALL NEW_INDEX_CODE_COMMANDE(1)";
 
          String newcode = "COM"+new WorkInDB().getUniqueValue(rq_index, "max")+
                  request.getParameter("idpa").replace("2018", "")+"U1"+
                  new WorkInDB().getUniqueValue(rq_index, "dt").replace("-", "");
          System.err.println("code = "+newcode);
           String s = " CODE PATIENT="+request.getParameter("idpa")+"\n CODE COMMANDE= "+newcode;
           
           req = "CALL CREATE_COMMANDE('"+request.getParameter("idpa")+"',1,'"
                   +newcode+"',"+r+","+idservice+","+idpraticien+")"; // 
           
          /* if (avance.equals("") ){
                req = "CALL CREATE_COMMANDE('"+request.getParameter("idpa")+"',1,'"+newcode+"',"+r+","+Integer.parseInt(request.getParameter("mt"))+"))";
           }else  if ( !avance.equals("") ){
             req = "CALL CREATE_COMMANDE('"+request.getParameter("idpa")+"',1,'"+newcode+"',"+Integer.parseInt(avance)+")";
           }*/
           
          
           

     if(new WorkInDB().Insert_Update_Delete(req)){
         
         String del_com = " delete from commande_temp "
                 + " where CodePatient = '"+request.getParameter("idpa")+"' and IDUtilisateur = 1";
          if(new WorkInDB().Insert_Update_Delete(del_com)){
                out.println(new Templates().getAlert("", "COMMANDE ENREGISTRER "+s, "alert-success"));
                 String srp ="<script type='text/javascript'> "
                    + "$(function () {"
                 + " $('#form-facturation').get(0).reset();"
                 + "executeCommande('' , 0 , 0, $('#Facturation-Code_Patient').val() , 'result-add-commande-patient' );"
                         + " location.href = 'impression/facture-hospitalisation-patient.jsp?cdecmd="+newcode+"';"
                 + " })(jQuery);"
                      + "</script> ";
         out.println(srp);
          }
       
     
         
        // String np = request.getParameter("nomp")+" "+request.getParameter("prenomp");
        
     } else{
        /* int n = request.getParameter("codep").length();
         String s = request.getParameter("codep").substring(0);
         out.println(new Templates().getAlert("", "n_send = "+n+" code_send = "+s, "alert-danger"));*/
         
         out.println(new Templates().getAlert("", "ECHEC ENREGISTREMENT COMMANDE"+s, "alert-danger"));
     }
  %>

   
    
   <script type='text/javascript'> 
 /**/ if()

</script>
      
