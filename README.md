# Escrow Contract

## Group members:

-   Kevin W: kevin.fncw@gmail.com
-   Jason C: jason.chen53@myhunter.cuny.edu

## Purpose of Contract:

In this contract, we set up an escrow system by making the arbiter the smart contract itself. Tokens are given by the seller to the smart contract to sell. When a buyer wants to purchase these tokens, they send funds directly to the smart contract. When this occurs, it will cause the smart contract to transfer those tokens to the buyer, and also give the recieved funds to the seller.

### To run:
   
Import code into [Remix](https://remix.ethereum.org), the Ethereum IDE to compile and deploy.

## Interface:
### Functions

name() returns the name of the token.

symbol() returns the token symbol.

totalSupply() returns the total amount of tokens in circulation.

tokenBalancesOf(address <i>_requester</i>) returns the total balance of tokens for a particular address.

etherBalancesOf(address <i>_requester</i>) returns the total balance of ether(in wei) for a particular address.

depositTokens(uint256 <i>_tokens</i>) uses ERC20 approve and transferFrom functions to deposit tokens into the smart contract and updates the token balance.

depositEther(uint256 <i>_etherAmount</i>) accepts incoming ether payment and updates the ether balance.

buyTokens(address <i>_seller</i>, address <i>_seller</i>, 
        address <i>_buyer</i>, 
        uint256 <i>_tokens</i>, 
        uint256 <i>_etherAmount</i>) allows a buyer to purchase tokens from a seller, updating the token and ether balances of both parties after the transaction.

withdrawTokens() allows a buyer to transfer their entire token balance into their own address.

### [Styling of Interface](https://solidity.readthedocs.io/en/v0.5.13/style-guide.html)