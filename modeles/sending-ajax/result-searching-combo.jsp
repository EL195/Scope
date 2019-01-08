
<%@page import="db_connections.WorkInDB"%>

  <%   out.println(new WorkInDB().getColumnToCombo(request.getParameter("Nomtable"), request.getParameter("colonne")));%>
    
    
   
      
