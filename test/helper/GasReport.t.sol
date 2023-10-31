// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

abstract contract GasReport is Test {
    using Strings for uint256;

    // use gasReport
    uint256 startGas;
    uint256 gasUsed;
    uint256 gasUsedForSettings;
    uint256 gasUsedForFunctions;
    uint256 totalAmounts;

    struct GasUsage {
        uint256 burnFirst;
        uint256 burnLast;
        uint256 mint;
        uint256 mintAverage;
        uint256 transferFromFirst;
        uint256 transferFromLast;
    }

    mapping(string => GasUsage) public gasUsages;

    function createGasReport(string memory targetContract, string[] memory keys) public {
        string memory path = string(abi.encodePacked("./dist/", targetContract, ".json"));

        string memory writeJson;
        string memory object;

        uint256 len = keys.length;

        for (uint256 i = 0; i < len;) {
            string memory key = keys[i];

            // create writeJson
            object = vm.serializeString("index", key, "");
            unchecked {
                i++;
            }
        }
        writeJson = vm.serializeString("result", "result", object);
        vm.writeJson(writeJson, path);

        for (uint256 i = 0; i < len;) {
            string memory key = keys[i];
            GasUsage memory gasUsage = gasUsages[key];

            // create writeJson
            object = vm.serializeUint(key, "mint", gasUsage.mint);
            object = vm.serializeUint(key, "mintAverage", gasUsage.mintAverage);
            object = vm.serializeUint(key, "transferFromFirst", gasUsage.transferFromFirst);
            object = vm.serializeUint(key, "transferFromLast", gasUsage.transferFromLast);
            object = vm.serializeUint(key, "burnFirst", gasUsage.burnFirst);
            object = vm.serializeUint(key, "burnLast", gasUsage.burnLast);

            writeJson = vm.serializeString(i.toString(), key, object);

            vm.writeJson(object, path, string(abi.encodePacked(".result.", key)));

            unchecked {
                i++;
            }
        }
    }
}
