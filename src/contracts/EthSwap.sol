pragma solidity ^0.5.0;

import './Token.sol';

contract EthSwap{
    string public name = "Bharath";
    Token public token;
    uint rate = 100;

  constructor(Token _token) public{
    token = _token;
  }
  
  event tokenPurchased(
    address account,
    address token,
    uint amount,
    uint rate
  );

  event tokensSold(
    address account,
    address token,
    uint amount,
    uint rate
  );
  function buyTokens() public payable{
    uint amount = msg.value * rate;

    require(token.balanceOf(address(this)) >= amount);
    token.transfer(msg.sender, amount);

    emit tokenPurchased(msg.sender, address(token), amount, rate);
  }

  function sellTokens(uint _amount) public {
    require(token.balanceOf(msg.sender)>= _amount);
    uint ethAmount = _amount / rate;
    require(address(this).balance >= ethAmount);
    token.transferFrom(msg.sender,address(this),_amount);
    msg.sender.transfer(ethAmount);

    emit tokensSold(msg.sender, address(token), _amount, rate);
  }
}

