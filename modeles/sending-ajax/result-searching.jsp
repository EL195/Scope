<%-- 
    Document   : result-searching
    Created on : 6 sept. 2018, 22:02:44
    Author     : TOSHIBA
--%>

<%@page import="beans.Core"%>
 <% 
     String NomTable = request.getParameter("table_name");
     String Libelle = request.getParameter("libelle_val");
     String sql = "select * from "
                    + ""+NomTable+" "
                    + "where Nom"+NomTable.toUpperCase().charAt(0)+NomTable.substring(1).toLowerCase()+" like '"+Libelle+"%'";
     request.setAttribute("col",  new Core().getLines(sql,request.getParameter("table_name"), request.getParameter("libelle_val")));
  %>
<c:forEach items="${col}" var="element">
    <tr>
        <td> <c:out value=" ${element.id}" > </c:out> </td>
        <td><c:out value=" ${element.libelle}" > </c:out> </td>
        <td class=" cell-selectionner" 
            onclick="placeValues('#Facturation-Numero_service','${element.id}',
                        '#Facturation-Libelle_service','${element.libelle}','#LibelleService');
                        $('#modal-search-service').modal('hide');
                        " >
            <center>
                 <img src='images/icones_20x20/cell-valider.png'>
            </center>
        </td>
    </tr> 
</c:forEach>
   
      
    <script type='text/javascript'>
        
    </script>