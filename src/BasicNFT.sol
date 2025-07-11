// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Dogie", "Dog") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        s_tokenCounter++;
        _safeMint(msg.sender, s_tokenCounter);
    }

    function tokenURI(uint256 _tokenId) public view override returns(string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}