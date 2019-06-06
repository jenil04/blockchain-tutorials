pragma solidity ^0.4.19;

contract ERC20Token {
    uint8 public decimals = 8;  

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
}