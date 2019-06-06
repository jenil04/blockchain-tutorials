pragma solidity ^0.4.19;

contract Contract {
	address public sender;
	address public recipient; 

	mapping (address => uint256) public balanceOf;
	event ApproveTransfer(uint256 value);

	function Contract() public {
		sender = msg.sender;
	}

	function transfer(uint _value) public payable onlyOwner {
		require(balanceOf[sender] >= _value);
		require(balanceOf[recipient] >= balanceOf[recipient] + _value); // prevent overflows.
		ApproveTransfer(_value);
        address(recipient).transfer(_value);	
	}

    modifier onlyOwner {
        require(msg.sender == sender);
        _;
    }

	function transferFrom(address _from, address _to, uint256 _value) public payable onlyOwner {
		ApproveTransfer(_value);
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
	}
}

