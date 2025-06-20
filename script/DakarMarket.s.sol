// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DakarMarket} from "../src/DakarMarket.sol";

contract CounteDakarMarketScript is Script {
    DakarMarket public dakarMarket;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        dakarMarket = new DakarMarket();

        vm.stopBroadcast();
    }
}
