<%-- 
    Document   : recevoir-req-ajax
    Created on : 1 sept. 2018, 20:00:13
    Author     : TOSHIBA
--%>

<%@page import="beans.Core"%>

        <h3>
            <p>
                <c:out value="Libelle = ${param['Libelle']}" > </c:out>
                 <% new Core().addColumn(request.getParameter("NomTable"), request.getParameter("Libelle")); %>
            </p>
             <p>
                 <c:out value="Table = ${param['NomTable']}" > </c:out>
                 <% //out.print("Table = "+request.getParameter("NomTable")+"\n"); %>
            </p>
           
        </h3>
 
