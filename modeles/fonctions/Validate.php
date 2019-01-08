<?php

if(!function_exists('validateInput')){
    function validateInput($data){
         /*htmlspecialchars($data) permet de ne plus interpreter le code html envoyer
          *strip_tags($data) fait htmlspecialchars($data) et de supprimer les caracteres speciaux
          * trim($data) permet de supprimer les espaces en trop dans la donnees
          *strip_tags($data) permet de supprimer les (\) dans lea donnee */

        /*$data = trim($data);
        $data = stripcslashes($data);
        $data = strip_tags($data);*/
     //   echo 'tager ='.strip_tags($data).'<br> trimer ='.trim($data).'<br>slacher ='.stripcslashes(trim(strip_tags($data))).'<br>';
        return trim(strip_tags(stripcslashes($data)));
        //return  strip_tags(stripcslashes(trim(htmlspecialchars($data))));

       // return $data;
    }
  /*  echo  '<p>cliquer <a href="#" >ici</a></p>';
    echo '<em>'.validateInput(' \   simo    sd   ').'</em>';*/
}
