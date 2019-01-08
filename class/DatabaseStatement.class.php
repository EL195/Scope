<?php
if (session_status() == PHP_SESSION_NONE){
    session_start();
    $_SESSION['user']['IDUser'] = 1;

    $user =  $_SESSION['user']['IDUser'];
    // $_SESSION['alert']="";
    $_SESSION['notification']="";
}


$sqlErrors = "";
class DatabaseStatement{
    private $host ='localhost';
    private $pass ='root';
    private $user ='root';
    private $database ='scope';
    private $pdo;
    public $sqlError ='';


    //double constructeur
    public	function __construct($host = null, $user= null , $pass = null , $database = null)	{
        //si on ne precise pas de host a la construction de l'objet
        if ( $host != null){
            $this->host = $host;
            $this->pass = $pass;
            $this->user = $user;
            $this->database = $database;
        }
    }

    public function getParameters(){
        return "host = ".$this->host."; user = ".$this->user."; pass = ".$this->pass."; db = ".$this->database."";
    }

    public function getColumnToCombo($query,$column_out,$id_column_out,$defaultOption='',$data=null){

        $opt ='';
        $opt ="<option value=''>".$defaultOption."</option>";

        try {
            $result = $this->getResultForSelect($query,$data);
            foreach ($result as $value) {
                $opt.= "<option value='".$value[$id_column_out]."'>".$value[$column_out]."</option>";
            }
         // echo('opt = '.$opt);
            return $opt;

        } catch (Exception $e) {
            $_SESSION["alert"]['danger'] = "ERREUR SQL : ".$e->getMessage();
            $this->sqlError = $e->getMessage();
        }

    }


    public function execute_update($requete,$data = null){
        try{

            $donnees = $this->getPDO()->prepare($requete);
            return $donnees->execute($data);
            // $result = $donnees->execute($data);

        }
        catch (SQLException $e) {
            $_SESSION["alert"]['danger'] = "ERREUR SQL : ".$e->getMessage();
            $this->sqlError = $e->getMessage();
            die ('<h1 class="error">ERREUR</h1></br> :'.$e->getMessage());

            // $result = false;
        }
        //   return $result;
    }

    public function getPDO(){
        try {
            if ($this->pdo === null) {
               /* $this->pdo = new PDO("mysql:host=$this->host;dbname=$this->database;charset=utf8", $this->user,
                    $this->pass, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION ));*/

                $this->pdo = new PDO("mysql:host=$this->host;dbname=$this->database;charset=utf8", $this->user,$this->pass);
                $this->pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
                $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE,PDO::FETCH_OBJ);
            }

        } catch (SQLException $e) {
            $_SESSION["alert"]['danger'] = "ERREUR SQL : ".$e->getMessage();
            $GLOBALS['$sqlErrors']   = $e->getMessage();
            die ('<h1 class="error">IMPOSSIBLE DE SE CONNECTER A LA BASE DE DONNEES</h1>
                </br><h4 style="color: darkorange;">DETAILS DES PARAMETRES DE CONNEXION: '.$this->getParameters().' </h4> 
                </br>l\'ERREUR EST :'.$e);
        }
        return $this->pdo;
    }


   public  function getResultForSelect($requete,$data=null){
        try {
            $donnees = $this->getPDO()->prepare($requete);
            $donnees->execute($data);

        } catch (Exception $e) {
            $_SESSION["alert"]['danger'] = "ERREUR SQL : ".$e->getMessage();
            $GLOBALS['$sqlErrors']   = $e->getMessage();
            $this->sqlError = $e->getMessage();
        }
        /*retourne toutes les  lignes de la requete
        * PDO::FETCH_ASSOC precise qu'on veut le resultat avec seulement les noms de colonnes
        */
        return $donnees->fetchAll(PDO::FETCH_ASSOC);
    }

    public  function getOnresult($requete,$data=null){
        try {
            $donnees = $this->getPDO()->prepare($requete);
            $donnees->execute($data);

        } catch (Exception $e) {
            $_SESSION["alert"]['danger'] = "ERREUR SQL : ".$e->getMessage();
            $this->sqlError = $e->getMessage();
        }
        /*retourne toutes les  lignes de la requete
        * PDO::FETCH_ASSOC precise qu'on veut le resultat avec seulement les noms de colonnes
        */
        return $donnees->fetch();
    }


}

