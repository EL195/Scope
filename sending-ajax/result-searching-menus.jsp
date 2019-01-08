
<%@page import="beans.Menu"%>

  <%   
      
       String IDU = request.getParameter("IDuser");
     String Idmod = request.getParameter("IDModule");
     
      //System.err.println("resut file = "+new Menu().getAllmenus(Integer.parseInt(IDU),Integer.parseInt(Idmod)));
     //Integer.parseInt(IDU),Integer.parseInt(Idmod)
      out.println(new Menu().getAllmenus(Idmod,IDU));
      
      
      //out.println("<h2 class='error-result-search'>"+"AUCUN MENU TROUVER"+"</h2>");
  %>
    
    
   
      
