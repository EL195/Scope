<%-- 
    Document   : result-searching
    Created on : 6 sept. 2018, 22:02:44
    Author     : TOSHIBA
--%>

<%@page import="beans.Core"%>
 <%   
     request.setAttribute("patient",  new Core().getLinesPatient(request.getParameter("nompatient")) );
  %>
<c:forEach items="${patient}" var="p">
     
             <tr id="line-result-patient-search" >
                <td></td>
                <td><c:out value=" ${p.codepatient}" > </c:out></td>
                <td><c:out value=" ${p.nompatient}" > </c:out></td>
                <td><c:out value=" ${p.prenompatient}" > </c:out></td>
                <td><c:out value=" ${p.sexepatient}" > </c:out> </td>
                <td><c:out value=" ${p.datenaissance}" > </c:out></td>
                <td><c:out value=" ${p.lieunaissance}" > </c:out> </td>
                 <td><c:out value=" ${p.emailpatient}" > </c:out> </td>
                <td><c:out value=" ${p.nomprofession}" > </c:out> </td>
               <td class="datatable-ct" style=""><i class="fa fa-trash"></i> </td>
            </tr>     
          
</c:forEach>
    
    <script> 
        $(function () { 
          /*  $('#modal-search-patient').on('hide.bs.modal', function () {
                alert('Hey, I heard you like modals...');
            }) ;*/
        });
 </script>
    
    
   
      
