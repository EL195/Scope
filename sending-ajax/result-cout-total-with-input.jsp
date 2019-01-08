
<%@page import="beans.Montant"%>
<%@page import="beans.Core"%>
<%@page import="db_connections.WorkInDB"%>

  <%   
    
     
      String rq ="CALL COUT_TOTAL_COMMANDE_TEMP_D_UN_PATIENT('"+request.getParameter("code")+"',1)";
      out.println(new Montant().getCTwithInput(rq));
      
      %>
      
   
    
   
      
