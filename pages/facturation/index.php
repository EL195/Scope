<%-- 
    Document   : index
    Created on : 2 déc. 2018, 22:38:58
    Author     : el
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
     <%@ include file = "/WEB-INF/import.jsp"  %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Scope - Facturation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <meta name="layout" content="main"/>
    
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>

    <script src="../../js/jquery/jquery-1.8.2.min.js" type="text/javascript" ></script>
    <link href="../../css/customize-template.css" type="text/css" media="screen, projection" rel="stylesheet" />

    <style>
    </style>
</head>
    <body>
       

        <div id="body-container">
            <div id="body-content">
                
                   
                
              
       <!-- <section class="nav nav-page">-->
        <div class="container">
            
                    <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item">
          <a class="nav-link active" data-toggle="tab" href="#assurance" role="tab">Assurance</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" data-toggle="tab" href="#souscripteur" role="tab">Souscripteur</a>
        </li>
      </ul>

      <div class="tab-content" role="tablist">
        <div class="tab-pane active" id="assurance" role="tabpanel">
            <%@ include file = "../../../modules/facturation.jsp"  %>
        </div>
          
        <div class="tab-pane" id="souscripteur" role="tabpanel">
        
        </div>
      </div>     
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
           <!-- <div class="row">
               
                <div class="page-nav-options">
                    <div class="span9">
                        
                        <ul class="nav nav-tabs">
                         
                            <li><a href="index.jsp?id=10">Facturationet et encaissement</a></li>
                            <li><a href="index.jsp?id=11">Pré-facturation</a></li>
                            <li><a href="index.jsp?id=12">Remises</a></li>
                            <li><a href="index.jsp?id=13">Liste des factures</a></li>
                        </ul>
                    </div>
                </div>-->
           <!-- </div>-->
        </div>
    <!--</section>>
                
       
	</body>
</html>