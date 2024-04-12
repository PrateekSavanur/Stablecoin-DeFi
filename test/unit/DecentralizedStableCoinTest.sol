// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;

    function setUp() external {
        dsc = new DecentralizedStableCoin();
    }

    function testMustMintMoreThanZero() public {
        vm.prank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(this), 0);
    }

    function testMustBurnMoreThanZero() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 1);
        vm.expectRevert();
        dsc.burn(0);
        vm.stopPrank();
    }

    function testCantBurnMoreThanBalance() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 1);
        vm.expectRevert();
        dsc.burn(2);
        vm.stopPrank();
    }

    function testCantMintToZeroAddress() public {
        vm.prank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(0), 1);
    }
}
