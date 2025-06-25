// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import {DakarToken} from "../src/DakarToken.sol";

contract DakarTokenMintScript is Script {
    function run() external {
        // Clé privée (ex: via variable d'env avec `--private-key`)
        address recipient = vm.envAddress("RECIPIENT");
        uint256 amount = 1000 ether; // 1000 DKR

        // Début de la diffusion (broadcast)
        vm.startBroadcast();

        // Référence du contrat déjà déployé
        DakarToken token = DakarToken(vm.envAddress("DAKAR_TOKEN_ADDRESS"));

        // Lecture de l’administrateur
        address admin = token.getAdmin();
        console.log("Admin du token Dakar:", admin);

        // Mint vers l'adresse définie
        token.mint(recipient, amount);
        console.log("Mint de 1000 DKR a:", recipient);

        vm.stopBroadcast();
    }
}
