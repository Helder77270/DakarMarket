// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DakarMarket} from "../src/DakarMarket.sol";

contract DakarMarketTest is Test {
    DakarMarket public dakarMarket;

    address public admin;
    address public buyer1;
    address public buyer2;

    function setUp() public {
        admin = address(0xAAAA);
        buyer1 = address(0x1111);
        buyer2 = address(0x2222);

        vm.startPrank(admin);
            dakarMarket = new DakarMarket(); // Déployer
        vm.stopPrank();

    }

    function test_CreateItemByAdmin() public {
         vm.startPrank(admin);
            dakarMarket.createItem("Cafe", 10 * 10**18);
         vm.stopPrank();

        DakarMarket.Object memory item0 = dakarMarket.getItem(0);

         assertEq(1, dakarMarket.objectCounter());
         assertEq("Cafe", item0.name);
         assertEq(10 * 10**18, item0.price);
         assertEq(block.timestamp, item0.arrival);
         assertEq(block.timestamp + 1 weeks, item0.peremption);
    }
    

}
