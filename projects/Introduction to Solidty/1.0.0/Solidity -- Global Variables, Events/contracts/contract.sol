pragma solidity ^0.4.19;

contract Contract {
	address public sender;
	address public recipient; 

	mapping (address => uint256) public balanceOf;
	event ApproveTransfer(uint256 value);

	function Contract() public {
		sender = msg.sender;
	}
}

