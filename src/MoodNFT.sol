// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    //error
    error MoodNFT__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory happySvg, string memory sadSvg) ERC721("Mood NFT", "MN"){
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvg;
        s_sadSvgImageUri = sadSvg;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        // one nft owner able to change mode
        // if (!_isApprovedOrOwner(msg.sender, tokenId)) {
        //     revert MoodNFT__CantFlipMoodIfNotOwner();
        // }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns(string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory) {
        string memory imageUri;
        if ( s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( 
                            abi.encodePacked('{"name": "', name(), '", "description": "An NFT that reflects owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "', imageUri, '"}'
                            )   
                        )
                    )
                )
            );

    }
}