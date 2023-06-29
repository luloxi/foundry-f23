# Proveably Random Raffle Contracts

To deploy to sepolia: `make deploy ARGS="--network sepolia"`

## About

This code is to create a proveably random smart contract lottery.

## What we want it to do?

1. Users can enter by paying for a ticket
   1. The ticket fes are going to go to the winner during the draw
2. After X period of time, the lottery will automatically draw a winner
   1. And this will be done programatically
3. Using Chailink VRF & Chainlink Automation
   1. Chainlink VRF -> Randomness
   2. Chainlink Automation -> Time based trigger

## How it works in a nutshell

1. Request the RNG -> Request to Chainlink VRF (pickWinner)
2. Get the random number and use it to pick a winner - Receive from Chainlink VRF (fulfillRandomWords)
3. Be automatically called to pick a winner on certain conditions - Chainlink Automation - time based (checkUpkeep and performUpkeep)

## Tests!

1. Write some deploy scripts
2. Write our tests
   1. Work on a local chain
   2. Forked Testnet
   3. Forked Mainnet

Remove console.log from code before deploying, because it costs gas
