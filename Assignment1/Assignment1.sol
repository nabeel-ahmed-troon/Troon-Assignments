//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract TroonToken is Ownable{

    using SafeMath for uint256;

    string private Name;
    string private Symbol;
    uint256 private totalSupply_;

    //address private owner;


    mapping (address=>uint) balances;
    mapping (address=>mapping(address=>uint)) allowed;

    constructor(string memory _name,string memory _symbol,uint256 _totalSupply )
    {
        Name=_name;
        Symbol=_symbol;
        totalSupply_=_totalSupply;
        balances[msg.sender]=totalSupply_;
       // owner=msg.sender;
    }
    
    function symbol() public view returns(string memory)
    {
        return Symbol;
    }
    function decimals() public pure returns(uint8){
        return 8;
    }
    function totalSupply() public view returns (uint256) 
    {
        return totalSupply_;
    }

    function balanceOf(address _ownerAddress) public view returns(uint256)
    {
        return balances[_ownerAddress];
    }

    function transfer(address _receiverAddress,uint _amount) public returns(bool success)
    {
        _transfer(_receiverAddress,_amount);

        return true;
    }

    function _transfer(address to,uint _amount) private {
        require(to!=address(0),"address is zero");
        require(_amount<=balances[msg.sender],"sender has not sufficient tokens:");
        balances[msg.sender]-=_amount;
        balances[to]+=_amount;
    }

    // modifier onlyOwner(){
    //     require(msg.sender==owner);
    //     _;
    // }

    function mint(address to, uint256 value) public onlyOwner returns (bool){

        _mint(to,value);
        return true;
    }

    function _mint(address to,uint256 value) private{

        balances[to]+=value;
        totalSupply_+=value;
    }

    
    function transferFrom(address owner, address receiver, uint256 amount ) public returns (bool success){
        
        require(amount<=balances[owner] && amount<= allowed[owner][msg.sender] );
        balances[owner]-=amount;
        allowed[owner][msg.sender]-=amount;
        balances[receiver]+=amount;
        return true;
    }

    function approve(address spender,uint256 amount ) public returns (bool){
        allowed[msg.sender][spender]=amount;

        return true;
        
    }

    function allowance(address _owner, address _spender) public view returns(uint256 remaining){
        return allowed[_owner][_spender];
    }

    




}