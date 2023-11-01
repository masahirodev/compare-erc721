// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "solmate/tokens/ERC721.sol";

contract Erc721 is ERC721 {
    uint256 public currentTokenId;

    constructor() ERC721("ERC721Solmate", "MTK") {}

    /// @dev Exceeds supply.
    error ExceedSupply();

    function mint(uint256 quantity) external payable {
        for (uint256 i = 0; i < quantity;) {
            _mint(msg.sender, currentTokenId);
            unchecked {
                currentTokenId++;
                i++;
            }
        }
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

    function supplyCheckMint(uint256 quantity) external payable {
        if (currentTokenId + quantity > 10_000) {
            revert ExceedSupply();
        }

        for (uint256 i = 0; i < quantity;) {
            _mint(msg.sender, currentTokenId);
            unchecked {
                currentTokenId++;
                i++;
            }
        }
    }

    // ---------- The following functions are overrides required by Solidity.---------- //
    function tokenURI(uint256 id) public view override returns (string memory) {}
}
