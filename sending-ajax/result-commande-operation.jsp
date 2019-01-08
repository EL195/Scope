<%-- 
    Document   : result-searching
    Created on : 6 sept. 2018, 22:02:44
    Author     : TOSHIBA
--%>

<%@page import="beans.CommandeTraitments"%>
<%@page import="beans.Commande"%>
<%@page import="beans.Core"%>


 <% 
     //idproduct idpatient op  qtec mt
     String idproduct = request.getParameter("idproduct");
     String idpatient = request.getParameter("idpatient");
     int qte = 0 ;
     int mt = 0 ;
     String sql = "";
     
      try{
          qte = Integer.parseInt(request.getParameter("qtec"));
          mt = Integer.parseInt(request.getParameter("mt"));
          //System.err.println("longuer mt ="+request.getParameter("mt").length()+" mt = "+request.getParameter("mt"));
        }catch(Exception e){
          System.err.println("erreur de transtipage de commande temp:"+e);
        }
     
    if (qte>0 && mt>0 && !idpatient.equals("") && !idproduct.equals("")){
         sql = "CALL ADD_COMMANDE_TEMP(1,"
             + "'"+idpatient+"','"+idproduct+"',"+qte+","+mt+")";
        
    }else if (qte ==0 && mt ==0 && !idpatient.equals("") && !idproduct.equals("")){
         sql = "delete from commande_temp"
                 + " where IDActe = '"+idproduct+"' and CodePatient = '"+idpatient+"'";
        
    }
    if (new CommandeTraitments().execute(sql) || idproduct.equals("")){
          String rq= "CALL DETAILS_COMMANDE_TEMP('"+idpatient+"',1)";
     
       request.setAttribute("c",  new CommandeTraitments().getListeCommande(rq,null));
     
    }
     
     
     
     
  %>
  
<c:forEach items="${c}" var="commande">
    <tr>
        <td> <c:out value="${commande.id}" > </c:out> </td>
        <td><c:out value="${commande.nomp}" > </c:out> </td>
        <td  id='<c:out value="cout${commande.id}" > </c:out>'> <c:out value="${commande.pu}" > </c:out> </td>
        <td>
            <div class="wrap-input100  input-qte">
                <input class="input100 " type="number" 
                          name="${commande.id}"
                          id='<c:out value="qte${commande.id}" > </c:out>'
                          value="${commande.qte}"
                          oninput="getMontant('${commande.id}');"
                          required="true"/>
                   <span class="focus-input100"></span>
            </div>
         </td>
      
        <td id='<c:out value="mt${commande.id}" > </c:out>'><c:out value="${commande.montant}" > </c:out> </td>
        
          <td  id='<c:out value="cout${commande.id}" > </c:out>'> 0% </td>
        <td class=" cell-selectionner" 
            id='btn-supprimer-commande'
             onclick=" executeCommande('${commande.id}',0, 0,
                        $('#Facturation-Code_Patient').val(),
                        'result-add-commande-patient');
                        //$('#modal-search-acte').modal('hide');
                        " >
             <span class="btn btn-danger fa fa-trash" ></span>
        </td>
    </tr> 
</c:forEach>
   
      
    <script type='text/javascript'>
        
    </script>