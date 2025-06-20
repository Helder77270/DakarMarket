// SPDX-License-Identifier: UNLICENSED

// Fichier de tests unitaires pour le contrat DakarMarket
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DakarMarket} from "../src/DakarMarket.sol";

contract DakarMarketTest is Test {
    // Instance du contrat à tester
    DakarMarket public dakarMarket;

    // Acteurs utilisés pendant les tests
    address public admin;   // l'administrateur du marché
    address public buyer1;  // premier acheteur fictif
    address public buyer2;  // second acheteur fictif

    /// @notice Fonction d'initialisation exécutée avant chaque test
    function setUp() public {
        // Attribution des adresses de test
        admin = address(0xAAAA);
        buyer1 = address(0x1111);
        buyer2 = address(0x2222);

        // Simulation des actions de l'administrateur
        vm.startPrank(admin);
            dakarMarket = new DakarMarket(); // Déploiement du contrat
        vm.stopPrank();

    }

    /// @notice Vérifie que seul l'admin peut créer un objet
    function test_CreateItemByAdmin() public {
         // L'administrateur crée un objet sur le marché
         vm.startPrank(admin);
            dakarMarket.createItem("Cafe", 10 * 10**18);
         vm.stopPrank();

        // Récupération de l'objet nouvellement créé
        DakarMarket.Object memory item0 = dakarMarket.getItem(0);

         // Vérifie que les informations de l'objet sont correctes
         assertEq(1, dakarMarket.objectCounter());
         assertEq("Cafe", item0.name);
         assertEq(10 * 10**18, item0.price);
         assertEq(block.timestamp, item0.arrival);
         assertEq(block.timestamp + 1 weeks, item0.peremption);
    }
    

}
