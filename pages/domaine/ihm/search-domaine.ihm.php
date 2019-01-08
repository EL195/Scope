<%@page import="beans.Templates"%>
<div class="container">
    <div class="row form-group">
     
    <% 
        out.println( new Templates().getTemplate("sending-ajax/result-searching-domaine.jsp","domaine","result-searching-domaine","LibelleDomaine"));
      
    %>
   

        
        
        
    </div>
</div>