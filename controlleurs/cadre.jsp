<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Scope</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- favicon
		============================================ -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
   
   <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Bootstrap CSS
		============================================ -->
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <!-- adminpro icon CSS
		============================================ -->
    <link rel="stylesheet" href="../css/adminpro-custon-icon.css">
    <!-- meanmenu icon CSS
		============================================ -->
    <link rel="stylesheet" href="../css/meanmenu.min.css">
    <!-- mCustomScrollbar CSS
		============================================ -->
    <link rel="stylesheet" href="../css/jquery.mCustomScrollbar.min.css">
    <!-- animate CSS
		============================================ -->
    <link rel="stylesheet" href="../css/animate.css">
    <!-- normalize CSS
		============================================ -->
    <link rel="stylesheet" href="../css/normalize.css">
    <!-- modals CSS
		============================================ -->
    <link rel="stylesheet" href="../css/modals.css">
    <!-- tabs CSS
		============================================ -->
    <link rel="stylesheet" href="../css/tabs.css">
    <!-- style CSS
		============================================ -->
    <link rel="stylesheet" href="../css/style.css">
    <!-- responsive CSS
		============================================ -->
    <link rel="stylesheet" href="../css/responsive.css">
    <!-- modernizr JS
		============================================ -->
    <script src="../js/vendor/modernizr-2.8.3.min.js"></script>
    
    <link rel="stylesheet" href="../css/style_input.css">
</head>

<body class="materialdesign">
    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
    <!-- Header top area start-->
  <div class="wrapper-pro">
        <!-- menu gauche-->
         <%@ include file = "menu-gauche.jsp"  %>
         <!-- end menu gauche-->
        <!-- Header top area start-->
        <div class="content-inner-all" >
             <!-- menu haut-->
              <%@ include file = "menu-haut.jsp"  %>
             <!-- end menu haut-->
            
            
            
            <!-- Menu Mobile-->
             <%@ include file = "menu-mobile.jsp"  %>
            <!-- Menu Mobile- end-->
            
            <div  id="menu-left" 
                  style="/*border: 2px solid black; height: 600px; width: auto;*/">
            
          
            </div>
             <%@ include file = "../pages/servlet.jsp"  %>
           <!-- chat box-->
             <%@ include file = "chat-box.jsp"  %>
            <!-- chat box end-->
        </div>
              <!-- Menu Mobile-->
             <%@ include file = "footer.jsp"  %>
            <!-- Menu Mobile- end-->
    </div>
  <%@ include file = "/WEB-INF/js-import.jsp"  %>
</body>
  
</html>
