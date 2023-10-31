// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract Erc721 is ERC721, ERC721Enumerable, ERC721Burnable {
    uint256 private _nextTokenId;

    constructor() ERC721("ERC721Oz", "MTK") {}

    /**
     * @dev no need to reentrancy guard
     * not allowed to mint from other contracts
     */
    function mint(uint256 quantity) external payable {
        // require(totalSupply() < 10, "All tokens are minted!");
        for (uint256 i = 0; i < quantity;) {
            _mint(msg.sender, _nextTokenId);
            unchecked {
                _nextTokenId++;
                i++;
            }
        }
    }

    /**
     * @dev not allowed to transfer from not owner
     */
    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        super.transferFrom(from, to, tokenId);
    }

    /**
     * @dev not allowed to burn from not owner
     */
    function burn(uint256 tokenId) public override {
        super.burn(tokenId);
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
