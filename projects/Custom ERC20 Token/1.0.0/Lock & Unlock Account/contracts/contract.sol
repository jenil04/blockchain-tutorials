pragma solidity ^0.4.19;

contract ERC20Token {
    string public name;
    string public symbol;
    uint8 public decimals = 8;  
    uint256 public totalSupply;

	uint256 public A_lock; 
    uint256 public A_spend;  
    uint256 public M; 
    
    uint256 public lockingTime; 
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    
    function ERC20Token(uint256 initialSupply, string tokenName, string tokenSymbol) public {
        totalSupply = initialSupply * 10 ** uint256(decimals); 
        balanceOf[msg.sender] = totalSupply;            
        name = tokenName;                                   
        symbol = tokenSymbol;                               
    }

    function _transfer(address _from, address _to, uint _value) internal {
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value > balanceOf[_to]);

        uint prevBalance = balanceOf[_from] + balanceOf[_to];
        balanceOf[_from] = balanceOf[_from] - _value;
        balanceOf[_to] = balanceOf[_to] + _value;
        assert(balanceOf[_from] + balanceOf[_to] == prevBalance);
    }

    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);     
        allowance[_from][msg.sender] = allowance[_from][msg.sender] - _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value); // Checking to see if the sender has balance >= value. 
        balanceOf[msg.sender] = balanceOf[msg.sender] - _value; // Burning the tokens.
        totalSupply = totalSupply - _value;
        return true;
    }


    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value); // Checking to see if the sender has balance >= value.
        balanceOf[_from] = balanceOf[_from] - _value; // Burning the tokens
        allowance[_from][msg.sender] = allowance[_from][msg.sender] - _value; // Burning allowance
        totalSupply = totalSupply - _value;                              
        return true;
    }


    function lock(address _recipient, address _pool) public {
        balanceOf[_recipient] = balanceOf[_recipient] - (A_lock); 
        balanceOf[_pool] = balanceOf[_pool] + (A_lock); 
        uint256 reward = (M * (A_lock)) + (A_spend); 
        balanceOf[_recipient] = balanceOf[_recipient] + (reward); 
    }
    

    function unlock(address _recipient, address _pool) public {
        require(lockingTime >= 90);
        balanceOf[_recipient] = balanceOf[_recipient]- A_lock; 
        balanceOf[_pool] = balanceOf[_pool] - A_lock; 
    }
}

