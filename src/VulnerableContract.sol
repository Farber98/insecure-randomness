// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
VulnerableContract is a game where you win 1 Ether if you can guess the
pseudo random number generated from block hash and timestamp.

At first glance, it seems impossible to guess the correct number.
But let's see how easy it is win.

1. Alice deploys VulnerableContract with 1 Ether
2. Eve deploys MaliciousContract
3. Eve calls MaliciousContract.attack() and wins 1 Ether

What happened?
MaliciousContract computed the correct answer by simply copying the code that computes the random number.
*/

contract VulnerableContract {
    constructor() payable {}

    function guess(uint256 _guess) public {
        uint256 answer = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );

        if (_guess == answer) {
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
        }
    }
}
