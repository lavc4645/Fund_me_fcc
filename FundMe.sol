// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {

    function fund() public payable  returns (bool) {
        /** Set minimum fund amount in USD
         * Send ETH to this contract
         * Reverting - undo any action before, and send remaining gas back
         */
        require(msg.value==1e18, "Don't send min amount")
        return true;
    }
}