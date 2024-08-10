// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev Implementation of a private ERC721 standard (PERC721).
 */
contract PERC721 is ERC721, Ownable(msg.sender) {
    uint256 private _currentTokenId = 0;

    /**
     * @dev Constructor that sets the name and symbol of the token.
     */
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    /**
     * @dev Function to mint new tokens.
     * @param to The address to mint the token to.
     */
    function mint(address to) external onlyOwner {
        _currentTokenId += 1;
        _mint(to, _currentTokenId);
    }
}
