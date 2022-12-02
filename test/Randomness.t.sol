// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/VulnerableContract.sol";
import "../src/MaliciousContract.sol";

contract Reentrancy is Test {
    VulnerableContract vulnerable;
    MaliciousContract malicious;

    address payable vulnerableContractDeployer1 = payable(address(0x1));
    address payable maliciousContractDeployer2 = payable(address(0x2));

    function setUp() public {
        vm.startPrank(vulnerableContractDeployer1);
        vm.deal(vulnerableContractDeployer1, 10 ether);
        vulnerable = new VulnerableContract{value: 10 ether}();
        vm.stopPrank();

        vm.startPrank(maliciousContractDeployer2);
        malicious = new MaliciousContract();
        vm.stopPrank();
    }

    function testMaliciousGuessRandomNumber() public {
        assertEq(address(vulnerable).balance, 10 ether);
        vm.startPrank(maliciousContractDeployer2);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        malicious.attack(vulnerable);
        vm.stopPrank();
        assertEq(address(vulnerable).balance, 0 ether);
    }
}
