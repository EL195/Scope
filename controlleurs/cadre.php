<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Scope</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php  require_once('css-import.php'); ?>
</head>

<?php  require_once('var-definition.php'); ?>
<body class="materialdesign">
<!--[if lt IE 8]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->

<div class="wrapper-pro">

        <!-- menu gauche-->
        <?php  require_once('menu-gauche.php'); ?>
        <!-- end menu gauche-->

    <!-- Header top area start-->
    <div class="content-inner-all" >

        <!-- menu haut-->
        <?php  require_once('menu-haut.php'); ?>
        <!-- end menu haut-->

        <div  id="menu-left"></div>
        <!-- Menu Mobile-->
        <?php  require_once('menu-mobile.php'); ?>
        <!-- Menu Mobile- end-->

        <?php  require_once('../pages/servlet.php'); ?>

        <!-- chat box-->
        <?php  require_once('chat-box.php'); ?>
        <!-- chat box end-->
    </div>

    <!-- footer-->
    <?php  require_once('footer.php'); ?>
    <!-- footer- end-->

    <!-- les modals-->
    <?php  require_once('modals.php'); ?>
    <!-- les modals- end-->

</div>

<?php  require('js-import.php');?>


</body>
  <script>
      $(function () {
          /*msg = 'Lorem ipsum dolor sit amet against apennine any created, spend loveliest, building stripes.';
          showNotification('error', {"delay":false, "msg":msg,"title":"titre", img:  'icones/me.png'});*/
      });
  </script>
</html>
