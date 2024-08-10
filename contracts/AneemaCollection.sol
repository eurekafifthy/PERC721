// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./PERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract AneemaCollection is PERC721, ERC721Burnable {
    uint256 private _currentTokenId = 0;
    
    // Mapping from token ID to token URI
    mapping(uint256 => string) private _tokenURIs;

    constructor() PERC721("Aneema Collection NFT", "ANFT") {}

    function mintTo(address recipient, string memory tokenURI) public onlyOwner returns (uint256) {
        uint256 newTokenId = _currentTokenId + 1;
        _currentTokenId++;
        _mint(recipient, newTokenId);
        _tokenURIs[newTokenId] = tokenURI;
        return newTokenId;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://beige-patient-cicada-388.mypinata.cloud/ipfs/";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "ERC721Metadata: URI query for nonexistent token");
        return bytes(_tokenURIs[tokenId]).length > 0
            ? _tokenURIs[tokenId]
            : string(abi.encodePacked(_baseURI(), Strings.toString(tokenId), ".json"));
    }

    // Function to set token URI
    function setTokenURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        require(_ownerOf(tokenId) != address(0), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = tokenURI;
    }
}
