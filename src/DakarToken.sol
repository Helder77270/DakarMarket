// SPDX-License-Identifier: MIT

// On prend la version 0.8.2 et celle du dessus
pragma solidity ^0.8.28;

// Import de la librairie pour faire des cryptos
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Héritage du fichier ERC20 dont l'utilité est de créer un token/jeton
// avec toutes les fonctions déjà écrites
contract DakarToken is ERC20 {

    address private admin;

    // Creation d'un type ERROR qui permet de 
    // retourner une erreur avec un code spécifique
    error NotAdmin();

    // Creation d'un type EVENT qui permet de notifier
    // les machines qui écoutent la blockchain d'une modification
    event NewAdmin(address oldAdmin, address newAdmin);

    // Objectif : La personne (addresse) qui déploie le smart-contract
    // sera administrateur

    // Ajout du constructor d'ERC20(crypto) afin de l'initialiser
    constructor() ERC20("Dakar", "DKR") {

        // msg.sender, prend automatiquement l'addresse de la personne
        // qui a lancé la transaction
        admin = msg.sender;
    }

    // Permet pré-traitement ou des post-traitement de fonction ou les deux
    modifier onlyAdmin(){
        // Vérifie que l'admin est celui qui appelle la fonction
        require(getAdmin() == msg.sender, NotAdmin());
        //Si oui, lance la fonction à laquelle le modifier est rataché
        _;
    }

    // ECRIRE LA FONCTION QUI PERMET DE LIRE LA VARIABLE admin
    function getAdmin() public view returns(address){
        return admin;
    }

    // Elle permet de mettre si et seulement si, la condition
    // du require est respecté, sinon elle renvoie l'erreur NotAdmin()
    // Enfin, quand cette condition est respectée alors on emet la notification NewAdmin
    // et on enregistre le nouvel administrateur
    // Il est important de noter, que l'on a ajouté le modifier onlyAdmin qui
    // pré-vérifie que seul l'admin puisse appelé la fonction
    function setAdmin(address _newAdmin) public onlyAdmin{
        emit NewAdmin(admin, _newAdmin);
        admin = _newAdmin;
    }

    // Permet de générer la crypto (imprimante à billet) mais seul l'admin 
    // a le droit d'activer la fonction, peu importe les paramètres
    // grâce à la protection du modifier onlyAdmin
    function mint(address account, uint256 value) external onlyAdmin {
        // _mint existe dans ERC20 mais n'est pas accessible pour un utilisateur
        // donc nous l'avons réimplémenté dans notre contrat en external
        _mint(account, value); 
    }
}

/* DEPLOYER LE SMART CONTRACT SUR L'ONGLET "DEPLOY"
MINT LES TOKENS POUR PLUSIEURS ADRESSES EN TANT QU'ADMINISTRATEUR
ENSUITE, FAIRE DES TRANSFERTS ENTRE ADRESSE
ENFIN, VERIFIER SI LES TRANSFERTS SE SONT BIEN PASSES EN UTILISANT BALANCEOF() */