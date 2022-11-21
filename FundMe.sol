// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    function fund() public payable  returns (bool) {
        /** Set minimum fund amount in USD
         * Send ETH to this contract
         * Reverting - undo any action before, and send remaining gas back
         */
        require(msg.value==1e18, "Don't send min amount")
        return true;
    }

    /** Getting the current ETH/USD value from chainlink */
    function getETHPriceInUSD() public returns (uint256) {
        //ABI 
        //Address - 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        /** ETH price in terms of USD */
        (,int256 priceInUSD,,,) = pricefeed.latestRoundData();
        returns uint256(priceInUSD * 1e10);             //1e10 = 10000000000
    }
}