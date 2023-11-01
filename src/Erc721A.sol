// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "erc721a/contracts/ERC721A.sol";
import "erc721a/contracts/extensions/ERC721ABurnable.sol";

contract Erc721 is ERC721A, ERC721ABurnable {
    constructor() ERC721A("ERC721A", "AZUKI") {}

    /// @dev Exceeds supply.
    error ExceedSupply();

    function mint(uint256 quantity) external payable {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

    /**
     * @dev not allowed to transfer from not owner
     */
    function transferFrom(address from, address to, uint256 tokenId) public payable override(ERC721A, IERC721A) {
        super.transferFrom(from, to, tokenId);
    }

    /**
     * @dev not allowed to burn from not owner
     */
    function burn(uint256 tokenId) public override {
        super.burn(tokenId);
    }

    function supplyCheckMint(uint256 quantity) external payable {
        if (totalSupply() + quantity > 10_000) {
            revert ExceedSupply();
        }

        _mint(msg.sender, quantity);
    }
}
