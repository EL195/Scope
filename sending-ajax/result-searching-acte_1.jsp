<%-- 
    Document   : result-searching
    Created on : 6 sept. 2018, 22:02:44
    Author     : TOSHIBA
--%>

<%@page import="db_connections.WorkInDB"%>
<%@page import="beans.Core"%>
 <% 
    
     String val_combo = request.getParameter("select");
     String Libelle = request.getParameter("libelle_val");
     String table = request.getParameter("table_name");
      String t = "";
      String rq = "";
      String IDDomaine ="";
     String sql ="";
     String suite = " where IDActe not in "
             + " (select IDActe from commande_temp where CodePatient = '"+request.getParameter("idpa")+"') "
             + " AND NomActe like '"+Libelle+"%' " ;;
     if (table.equals("")){
         sql = " select * from acte "+suite;
     }else if(Libelle.equals("") && !table.equals("")){
           t = new Core().getNameColumn(table);
          rq =" select ID"+t+" from "+table+" where Nom"+t+" = '"+val_combo+"'";
          IDDomaine = new WorkInDB().getUniqueValue(rq, "ID"+t);
     System.err.println("IDomaine = "+IDDomaine);
         sql = "select * from acte "+suite
                    + " AND ID"+t+" =  "+IDDomaine;
                 
     }
     else if (!table.equals("")&& !Libelle.equals("")){
          t = new Core().getNameColumn(table);
          rq =" select ID"+t+" from "+table+" where Nom"+t+" = '"+val_combo+"'";
          IDDomaine = new WorkInDB().getUniqueValue(rq, "ID"+t);
     System.err.println("IDomaine = "+IDDomaine);
         sql = "select * from acte "+ suite
                    + " AND ID"+t+" =  "+IDDomaine;
     }
   //else if (table.equals("") && (!Libelle.equals("") || Libelle.equals("") )){
          /*t = new Core().getNameColumn(table);
          //rq =" select ID"+t+" from "+table+" where Nom"+t+" = '"+val_combo+"'";
         // IDDomaine = new WorkInDB().getUniqueValue(rq, "ID"+t);
     System.err.println("IDomaine = "+IDDomaine);
         sql = "select * from acte "+ suite
             + " AND NomActe like '"+Libelle+"%' ";
     }*/
   
          /*   + "AND IDActe not in "
             + " (select IDActe from commande_temp where CodePatient = '"+request.getParameter("idpa")+"') ";*/
     request.setAttribute("colactes",  new Core().getLines(sql,"acte", request.getParameter("libelle_val")));
  %>
<c:forEach items="${colactes}" var="element">
    <tr>
        <td> <c:out value=" ${element.id}" > </c:out> </td>
        <td><c:out value=" ${element.libelle}" > </c:out> </td>
        <td class="td-pu"
            id='<c:out value="couta${element.id}" > </c:out>'> <c:out value=" ${element.cout}" > </c:out> </td>
         <td>  
                 <input type="hidden" id='<c:out value="mt${element.id}" > </c:out>'
                value='${element.cout}'/> 
                 <input type="hidden" id='<c:out value="cout${element.id}" > </c:out>' 
                        value='${element.cout}'  /> 
            <div class="wrap-input100">
                <input class="input100" type="number" 
                          name="${element.id}"
                          id='<c:out value="qte${element.id}" > </c:out>'
                          value="1"
                          oninput="getMontant('${element.id}');"
                          required="true"/>
                   <span class="focus-input100"></span>
            </div>
         </td>
        
         <td class="td-number"
             id='<c:out value="mta${element.id}" > </c:out>'>
            <c:out value="${element.cout}" > </c:out> 

         </td>
      
        
        <td class="td-add-commande cell-selectionner" 
            id='btn-ajouter-commande'
            onclick=" executeCommande('${element.id}',
                        $('#qte'+'${element.id}').val(),
                        parseInt($('#mt'+'${element.id}').val()),
                        $('#Facturation-Code_Patient').val(),
                        'result-add-commande-patient');
                goSearching('','', '../sending-ajax/result-searching-acte.jsp', 
                '#result-searching-acte',$('#Facturation-Nom_domaine').val());
                        //$('#modal-search-acte').modal('hide');
                        
                        " >
            <center>
                <span class="btn btn-success fa fa-plus-square-o" ></span>
            </center>
        </td>
    </tr> 
</c:forEach>
   
    <h1>sdgsuydgu</h1>
   