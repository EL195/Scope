
<%@page import="beans.Core"%>
<%@page import="db_connections.WorkInDB"%>

  <%   
      String table = request.getParameter("table");
      String t = new Core().getNameColumn(table);
      String rq =" select ID"+t+" from "+table+" where Nom"+t+" = '"+request.getParameter("valcolonne")+"'";
      String r = "<input type='number' style='/*display: none;*/'"
              + " id='Facturation-Num_domaine'"
              + " value='"+new WorkInDB().getUniqueValue(rq, "ID"+t)+"' />";
      out.println(r);
      //System.err.println("result = "+new WorkInDB().getUniqueValue(rq, "ID"+t));
      %>
      
   
    
   
      
