// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/** Gives current ETH/USD price using the chainlink decentralized nodes */
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    /** Minimum value in USD which should be transferred */
    uint256 minimumUSD = 50 * 1e18; // 50_0000000000000000 (unit conversion)
    address[] public funders; 
    mapping (address => uint256) public fundAmount;

    function fund() public payable returns (bool) {
        /** Set minimum fund amount in USD
         * Send ETH to this contract
         * Reverting - undo any action before, and send remaining gas back
         */
        require(
            convertEthAmountInUSD(msg.value) >= minimumUSD,
            "Don't send min amount"
        );
        funders.push[msg.sender];
        fundAmount[msg.sender] = msg.value;
        return true;
    }

    /** Getting the current 1 ETH value in USD  from chainlink */
    function getETHPriceInUSD() public view returns (uint256) {
        //ABI
        //Address - 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface pricefeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        /** ETH price in terms of USD */
        (, int256 priceInUSD, , , ) = pricefeed.latestRoundData();
        /** msg.value => 18 decimals
         * priceInUSD => 8 decimals
         * so, priceInUSD * 1e10 => 18 decimals
         *  priceInUSD == msg.value (in decimal places => 18 decimals)
         */
        return uint256(priceInUSD * 1e10); //1e10 = 10000000000
    }

    function convertEthAmountInUSD(uint256 ethAmount) public returns (uint256) {
        uint256 ethPrice = getETHPriceInUSD(); // 1087_000000000000000000

        /** (value to 1 ETH in USD) ethPrice => 1087_000000000000000000
         *  (total-no of ethers)    ethAmount =>   1_000000000000000000
         * ethPrice * ethAmount  gives ==> 1e36
         *  Again convert '1e36' into '1e18' by dividing the whole no by '1e18'
         */
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
}
