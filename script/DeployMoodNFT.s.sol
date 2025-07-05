// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {MoodNFT} from "src/MoodNFT.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {

    function run() external returns(MoodNFT) {
        string memory happySvg = vm.readFile("./Images/Happy.svg");
        string memory sadSvg = vm.readFile("./Images/Sad.svg");

        vm.startBroadcast();
            MoodNFT moodNFT= new MoodNFT(svgToImageUri(happySvg), svgToImageUri(sadSvg));
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToImageUri(string memory svg) public pure returns(string memory) {
        string memory baseURL = "data:image/svg+xm;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}