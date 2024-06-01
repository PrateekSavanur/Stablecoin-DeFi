// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/*
 * @title DecentralizedStableCoin
 * Author Prateek Savanur
 * @notice THis lib is used to check oracle for stale data
 * 
 * If a price is stale, the function will revert and render the DSCEngine unsable
 * We want DSCEngine to freeze if price becomes stale
 */

library OrableLib {
    error OracleLib__StalePrice();

    // Actually 1 hour but gave 3 hours
    uint256 private constant TIMEOUT = 3 hours;

    function staleCheckLatestRoundData(AggregatorV3Interface priceFeed)
        public
        view
        returns (uint80, int256, uint256, uint256, uint80)
    {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            priceFeed.latestRoundData();

        if (updatedAt == 0 || answeredInRound < roundId) {
            revert OracleLib__StalePrice();
        }
        uint256 secondsSince = block.timestamp - updatedAt;
        if (secondsSince > TIMEOUT) revert OracleLib__StalePrice();

        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }

    // Can get actual timeout
    function getTimeout(AggregatorV3Interface /* priceFeed */ ) public pure returns (uint256) {
        return TIMEOUT;
    }
}
