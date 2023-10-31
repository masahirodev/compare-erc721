// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./helper/TestHelpers.t.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// import {Erc721} from "src/Erc721Oz.sol";
// import {Erc721} from "src/Erc721A.sol";
// import {Erc721} from "src/Erc721Solmate.sol";
import {Erc721} from "src/Erc721Psi.sol";

// forge test --match-contract BaseCheck

contract BaseCheck is TestHelpers {
    using Strings for uint256;

    Erc721 public erc721Contract;

    function setUp() public {
        erc721Contract = new Erc721();
    }

    /**
     * @dev Test to see if anyone other than the owner can operate it
     */
    function testFailTransferFrom(address owner, address notOwner) public User(owner) {
        vm.assume(owner != zeroAddress && notOwner != zeroAddress && owner != notOwner);

        uint256 quantity = 1;
        uint256 tokenId = quantity - 1;

        erc721Contract.mint(quantity);

        // msg.sender = from --> to
        vm.startPrank(notOwner);

        erc721Contract.transferFrom(owner, notOwner, tokenId);
    }

    /**
     * @dev Test to see if anyone other than the owner can operate it
     */
    function testFailBurn(address owner, address notOwner) public User(owner) {
        vm.assume(owner != zeroAddress && notOwner != zeroAddress && owner != notOwner);

        uint256 quantity = 1;
        uint256 tokenId = quantity - 1;

        erc721Contract.mint(quantity);

        // msg.sender = from --> to
        vm.startPrank(notOwner);

        erc721Contract.burn(tokenId);
    }
}
