<%-- 
    Document   : result-searching
    Created on : 6 sept. 2018, 22:02:44
    Author     : TOSHIBA
--%>

<%@page import="beans.Core"%>
 <% 
     String IDU = request.getParameter("IDuser");
     String Idmod = request.getParameter("IDModule");
     out.println("<h3 style='blue'> user "+IDU+"</h3>");  
    System.err.println("user = "+IDU+" module = "+Idmod);
    
     request.setAttribute("menu",  new Core().getLinesMenu(Integer.parseInt(IDU),Integer.parseInt(Idmod)));
        
  %>
  
  <%    %>
   <!--<div class="col-md-3 nav-page" id="nav-page">-->
               <!-- <h3>Parametres</h3>-->
            <ul class="nav nav-stacked ">
                
                <span class="nav-header"><img src="images/icones_20x20/user_menu.png"> TOUS LES MENUS 
                    <ul class="nav nav-stacked collapse in" id="userMenu">
                        <c:forEach items="${menu}" var="me">
                        <li class=""> <a href="${me.lienmenu}"><img src="images/icones_20x20/${me.nommenu}.png"> <c:out value="${me.nommenu}" > </c:out></a></li>
                         
                        </c:forEach>
                    </ul></span></ul> <hr>

           
     <!-- </div>-->

   
      
   