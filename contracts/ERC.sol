// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./proxiable.sol";

contract METOKEN is Proxiable{
    mapping(address => uint256) public _balances;
    uint256 public _totalSupply;
    string public _name;
    string public _symbol;
    bool public intials;

    modifier intialised() {
        require(intials == true, "can't call this function");
        _;
    }      

    function intialise(uint totalSupply, string memory name, string memory symbol) external{
        require(intials == false, "already deployed");
        _totalSupply = totalSupply;
        _name = name;
        _symbol = symbol;
        intials = true;
    }

    function mint(address account, uint256 amount) external intialised{
        require(account != address(0), "ERC20: mint to the zero address");
        require(_totalSupply > amount, "not enough to mint");
        _balances[account] = amount;     
    }

    function transfer(address from, address to, uint amount) external intialised{
        uint balanceofsender = _balances[from]; 
        require(balanceofsender > amount, "not enough to send");
        _balances[from] =  _balances[from] - amount;
        _balances[to] =  _balances[to] - amount;
    }  
     
    function checkbal(address checker) external view intialised() returns(uint){
        return   _balances[checker];
    } 

    function encode(uint256 totalSupply, string memory name, string memory symbol) external pure  returns(bytes memory) {
        return abi.encodeWithSignature("intialise(uint256,string,string)", totalSupply,name,symbol);
    }

    function updateCode(address updateadd) external{
        updateCodeAddress(updateadd);
    }
}