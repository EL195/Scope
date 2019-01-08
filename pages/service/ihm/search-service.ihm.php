<%@page import="beans.Templates"%>
<div class="container">
    <div class="row form-group">
       <span class="txt1 col-sm-2">LIBELLE:</span>
       <div class="col-sm-12">
            <div class="wrap-input100">
                <input class="input100" type="text"
                        id="LibelleSearch"
                        placeholder ="Libellé"
                        oninput=" goSearching('service',$('#LibelleSearch').val()); "/>
                <img src='../images/icones/search.png' class="icones-txt-right btn" 
                     onclick="goSearching('service',$('#LibelleSearch').val());">
                <span class="focus-input100"></span>
            </div>
        </div>
    </div>
    <% 
        //out.println( new Templates().getTemplate("sending-ajax/result-searching.jsp","service","result-searching","LibelleService"));
      
    %>
   <div class="form-group">
          <table class="table table-hover table-bordered ">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Libellé</th>
                        <th>Selectionner</th> 
                    </tr>
                </thead>
                <tbody id="result-searching">
                   
                  
                </tbody>
            </table>

        
        
        
    </div>
</div>