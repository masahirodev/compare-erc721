// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "erc721psi/contracts/ERC721Psi.sol";
import "erc721psi/contracts/extension/ERC721PsiBurnable.sol";

contract Erc721 is ERC721PsiBurnable {
    constructor() ERC721Psi("ERC721Psi", "ADVENTURER") {}

    uint256 private counter;

    /// @dev Exceeds supply.
    error ExceedSupply();

    function mint(uint256 quantity) external payable {
        // _safeMint's second argument now takes in a quantity, not a tokenId. (same as ERC721A)
        _mint(msg.sender, quantity);
    }

    /**
     * @dev not allowed to transfer from not owner
     */
    function transferFrom(address from, address to, uint256 tokenId) public override {
        super.transferFrom(from, to, tokenId);
    }

    /**
     * @dev need to check if the sender is the owner
     */
    function burn(uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner, "Not the owner");
        _burn(tokenId);
    }

    // function supplyCheckMint(uint256 quantity) external payable {
    //     if (totalSupply() + quantity > 10_000) {
    //         revert ExceedSupply();
    //     }
    //     _mint(msg.sender, quantity);
    // }

    function supplyCheckMint(uint256 quantity) external payable {
        if (counter + quantity > 10_000) {
            revert ExceedSupply();
        }
        counter = counter + quantity;
        _mint(msg.sender, quantity);
    }
}
