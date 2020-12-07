// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/token/ERC20/ERC20.sol";
/** 
 * @title Owned
 * @dev Base contract to represent ownership of a contract
 * @dev Sourced from Mastering Ethereum at https://github.com/ethereumbook/ethereumbook
 */
contract Owned {
	address payable public owner;

	// Contract constructor: set owner
	constructor() {
		owner = msg.sender;
	}
	// Access control modifier
	modifier onlyOwner {
		require(msg.sender == owner,
		        "Only the contract owner can call this function");
		_;
	}
}

/** 
 * @title Mortal
 * @dev Base contract to allow for construct to be destructed
 * @dev Sourced from Mastering Ethereum at https://github.com/ethereumbook/ethereumbook
 */
contract Mortal is Owned {
	// Contract destructor
	function destroy() public onlyOwner {
		selfdestruct(owner);
	}
}


contract TokenContract is ERC20, Mortal {
    
    constructor() public ERC20("Token", "TKN") {
        _mint(msg.sender, 1000000);
    }
    
    mapping ( address => uint256 ) private totalBalances;
    
    fallback() external payable {}
    receive() external payable {}
    
    function totalBalancesOf(address _requester) public view returns (uint256) {
        return totalBalances[_requester];
    }

    function depositTokens(uint256 _tokens) public {
        ERC20.approve(msg.sender, _tokens);
    
        // transfer the tokens from the sender to this contract
        ERC20.transferFrom(msg.sender, address(this), _tokens);
        
        // add the deposited tokens into existing balance, records how much the sender has put into the smart contract 
        totalBalances[msg.sender] += _tokens;
    }
    
    function returnTokens() public {
        totalBalances[msg.sender] = 0;
        ERC20.transfer(msg.sender, totalBalances[msg.sender]);
    }
    
    function buyTokens(address _seller, address _buyer, uint256 _tokens, uint256 _etherAmount) payable public {
        require(msg.value == _etherAmount);
        totalBalances[_seller] -= _tokens;
        totalBalances[_buyer] += _tokens;
    }
    
    function withdrawTokens(address _buyer, uint256 _tokens) public {
        require(totalBalances[_buyer] >= _tokens, "Error: Not enough tokens to withdraw.");
        ERC20(address(this)).transfer(_buyer, _tokens);
        totalBalances[_buyer] -= _tokens;
    }
  
}
