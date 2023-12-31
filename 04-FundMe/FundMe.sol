// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

// constant, immutable

// 859,757
// 840,197

error NotOwner();


contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;
    // 21,415 gas - constant
    // 23.515 gas - non-constant

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;
    // 21,508 gas - immutable
    // 23,644 gas - non-immutable

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough ETH");
        // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // msg.sender = address
        // payable(msg.sender) = payable address
        
        // transfer (automatically reverts if transfer fails)
        // payable(msg.sender).transfer(address(this).balance);

        // send (returns boolean if transfer fails)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner!");
        // This is more gas efficient than require:
        if (msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    // Help for solving the QR challenge after getting the latestRoundData from the AggregatorV3 contract
    function multiplier(uint256 numberToMultiply) public pure returns (uint256) {
        return numberToMultiply * 10e10;
    }

    // What happens if someone sends this contract ETH without calling the fund function?

    receive() external payable {
       fund(); 
    }

    fallback() external payable {
       fund(); 
    }
}