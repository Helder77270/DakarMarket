// SPDX-License-Identifier: MIT

// On prend la version 0.8.2 et celle du dessus
pragma solidity ^0.8.28;

import {DakarToken} from "./DakarToken.sol";

contract DakarMarket is DakarToken{

    //Creation du type Object
    struct Object {
        string name;
        uint256 price;
        address owner;
        uint256 arrival; // Timestamp/Date = uint256
        uint256 peremption; // Timestamp/Date = uint256
    }

    mapping (uint256 id => Object) public stock;
    uint256 public objectCounter;

    error CantBuyOwnItem(address buyer);
    error NotEnoughBalance(uint256 expectedValue, uint256 balance);

    constructor(){

    }

    function createItem(string memory _name, uint256 _price) external onlyAdmin {
        // Rempli la struct Object
        Object memory obj = Object(_name, _price, address(this), block.timestamp, block.timestamp + 1 weeks);
        // On l'enregistre dans le mapping
        stock[objectCounter] = obj;
        //Incrémente l'index de 1 à chaque création, de cette manère on avance dans le mapping sans jamais ecraser d'informations
        objectCounter++;
    }

    /*
    Un utilisateur doit pouvoir acheter un object s'il a assez de DakarToken
    Si oui, alors mettre l'owner de la structure Object à son nom sinon renvoyer une erreur
    */
  function buyItem(uint256 _id) external {
        Object storage item = stock[_id];
        address buyer = msg.sender;
        require(item.owner != buyer, CantBuyOwnItem(buyer));
        require(balanceOf(buyer) >= item.price, NotEnoughBalance(item.price, balanceOf(buyer)));

        item.owner = buyer;

        // Optimal, car c'est l'utilisateur qui envoie de force ses tokens
        _transfer(buyer, item.owner, item.price);

        //Optimal et sécurisé
        transfer(item.owner, item.price);
        
                
    }
    // Créer la fonction getItem()
     function getItem(uint256 _id) public view returns (Object memory){
        return stock[_id];
     }

     // Créer la fonction getItem()
     function getItem2(uint256 _id) public view returns (string memory, uint256, address, uint256, uint256){
        return(
            stock[_id].name, 
            stock[_id].price, 
            stock[_id].owner, 
            stock[_id].arrival, 
            stock[_id].peremption
        );
     }

// mapping (uint256 id => Object) public stock; --> En tableau
     function getAllObjects() public view returns (Object[] memory){
        // 
        Object[] memory allObjects = new Object[](objectCounter);

        for (uint256 i = 0; i < objectCounter; i++){
            allObjects[i] = stock[i];
        }

        return allObjects;
     }
}