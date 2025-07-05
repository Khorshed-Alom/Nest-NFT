// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {BasicNFT} from "src/BasicNFT.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;

    address USER = makeAddr("USER");
    string public constant pug = "ipfs://QmXudy2Areh2xyUJq2L5sdTNNSLhESpP4xfB3S5CGgCTa6";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNFT.name();

        //assert(expectedName == actualName);
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAandHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNft(pug);
        assert(basicNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(pug)) == keccak256(abi.encodePacked(basicNFT.tokenURI(0))));
    }
}