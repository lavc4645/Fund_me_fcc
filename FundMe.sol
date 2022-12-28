// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/** Gives current ETH/USD price using the chainlink decentralized nodes */
import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    /** Minimum value in USD which should be transferred */
    uint256 minimumUSD = 50 * 1e18; // 50_0000000000000000 (unit conversion)
    address[] public funders; 
    mapping (address => uint256) public fundAmount;

    function fund() public payable returns (bool) {
        /** Set minimum fund amount in USD
         * Send ETH to this contract
         * Reverting - undo any action before, and send remaining gas back
         */
        // require(
        //     convertEthAmountInUSD(msg.value) >= minimumUSD,
        //     "Don't send min amount"
        // );
        require(msg.value.convertEthAmountInUSD() >= minimumUSD, "Don't send min amount");
        funders.push(msg.sender);
        fundAmount[msg.sender] = msg.value;
        return true;
    }

   
}
