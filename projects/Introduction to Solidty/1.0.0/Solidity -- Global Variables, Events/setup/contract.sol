pragma solidity ^0.4.19;

contract Contract {
	address public sender;
	address public recipient; 

	mapping (address => uint256) public balanceOf;

	function Contract() public {
	}
}

