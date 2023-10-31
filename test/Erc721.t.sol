// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./helper/TestHelpers.t.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// import {Erc721} from "src/Erc721Oz.sol";
// import {Erc721} from "src/Erc721A.sol";
// import {Erc721} from "src/Erc721Solmate.sol";
import {Erc721} from "src/Erc721Psi.sol";

// forge test --match-contract Erc721Test

contract Erc721Test is TestHelpers {
    using Strings for uint256;

    Erc721 public erc721Contract;

    function testCheckGas(address from, address to) public {
        vm.assume(from != zeroAddress && to != zeroAddress);

        string[] memory keys = new string[](9);
        erc721Contract = new Erc721();
        keys[0] = forEachFunction(from, to, 1, 1);

        erc721Contract = new Erc721();
        keys[1] = forEachFunction(from, to, 5, 1);

        erc721Contract = new Erc721();
        keys[2] = forEachFunction(from, to, 10, 1);

        erc721Contract = new Erc721();
        keys[3] = forEachFunction(from, to, 1, 1000);

        erc721Contract = new Erc721();
        keys[4] = forEachFunction(from, to, 5, 1000);

        erc721Contract = new Erc721();
        keys[5] = forEachFunction(from, to, 10, 1000);

        erc721Contract = new Erc721();
        keys[6] = forEachFunction(from, to, 1, 10000);

        erc721Contract = new Erc721();
        keys[7] = forEachFunction(from, to, 5, 10000);

        erc721Contract = new Erc721();
        keys[8] = forEachFunction(from, to, 10, 10000);

        createGasReport(erc721Contract.name(), keys);
    }

    // Gas test for each function
    function forEachFunction(address from, address to, uint256 quantity, uint256 premintQuantity)
        public
        User(from)
        returns (string memory key)
    {
        key = string(abi.encodePacked("mint", quantity.toString(), "premint", premintQuantity.toString()));

        uint256 firstTokenId = premintQuantity;
        uint256 lastTokenId = firstTokenId + quantity - 1;

        // Initialization
        gasUsages[key].mint = 0;
        gasUsages[key].mintAverage = 0;
        gasUsages[key].transferFromFirst = 0;
        gasUsages[key].transferFromLast = 0;
        gasUsages[key].burnFirst = 0;
        gasUsages[key].burnLast = 0;

        // premint
        if (premintQuantity > 0) {
            erc721Contract.mint(premintQuantity);
        }

        // check mint
        startGas = gasleft();
        erc721Contract.mint(quantity);
        gasUsages[key].mint = startGas - gasleft();
        gasUsages[key].mintAverage = gasUsages[key].mint / quantity;

        // check transferFrom first
        startGas = gasleft();
        erc721Contract.transferFrom(from, to, firstTokenId);
        gasUsages[key].transferFromFirst = startGas - gasleft();

        // check transferFrom last
        if (firstTokenId != lastTokenId) {
            startGas = gasleft();
            erc721Contract.transferFrom(from, to, lastTokenId);
            gasUsages[key].transferFromLast = startGas - gasleft();
        } else {
            gasUsages[key].burnLast = 0;
        }

        // msg.sender = from --> to
        vm.startPrank(to);

        // check burn first
        startGas = gasleft();
        erc721Contract.burn(firstTokenId);
        gasUsages[key].burnFirst = startGas - gasleft();

        // check burn last
        if (firstTokenId != lastTokenId) {
            startGas = gasleft();
            erc721Contract.burn(lastTokenId);
            gasUsages[key].burnLast = startGas - gasleft();
        } else {
            gasUsages[key].burnLast = 0;
        }
    }
}
