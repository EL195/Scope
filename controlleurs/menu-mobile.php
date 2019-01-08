  <div class="mobile-menu-area">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="mobile-menu">
                                <nav id="dropdown">
                                    <ul class="mobile-menu-nav">
                                        <?php  include('nav.php'); ?>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


 <!-- Breadcome start-->
            <div class="breadcome-area mg-b-30 des-none">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="breadcome-list map-mg-t-40-gl shadow-reset">
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" id="result-Query">
                                        <?php if (isset($_SESSION['alert'])): ?>
                                            <?php foreach ($_SESSION['alert'] as $type => $message ):
                                                $class = 'alert alert-dismissable alert-'.$type;?>
                                                <div class='<?php echo $class; ?>'>
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true"> &times; </button>
                                                    <?php  echo $message; ?>
                                                </div>
                                            <?php endforeach; ?>
                                        <?php endif; ?>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <ul class="breadcome-menu">
                                            <li><a href="#">Accueil</a> <span class="bread-slash">/</span>
                                            </li>
                                            <li>
                                                <span class="bread-blod">
                                                    <?php  if(isset($_GET['titre'])) {echo $_GET['titre'];}?>
                                                </span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcome End-->

