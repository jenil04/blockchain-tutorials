pragma solidity ^0.4.19;

contract Contract {
	address public sender;
	address public recipient; 

	mapping (address => uint256) public balanceOf;
	event ApproveTransfer(uint256 value);

	function Contract() public {
		sender = msg.sender;
	}

	function transfer(uint _value) public payable {
		ApproveTransfer(_value);
        address(recipient).transfer(_value);	
	}

	function transferFrom(address _from, address _to, uint256 _value) public payable {
		ApproveTransfer(_value);
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
	}
}

