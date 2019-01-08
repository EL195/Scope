
<%@page import="beans.Core"%>
<%@page import="db_connections.WorkInDB"%>

  <%   
    
     
      String rq ="CALL COUT_TOTAL_COMMANDE_TEMP_D_UN_PATIENT('"+request.getParameter("code")+"',1)";
      String  r  = new WorkInDB().getUniqueValue(rq, "CT");
   
     if( r !=null){
         out.println(r);
     }else{
         out.println("0");
     }
      
      %>
      
   
    
   
      
