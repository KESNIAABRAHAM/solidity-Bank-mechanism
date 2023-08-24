// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank {

    //create owner and constructor 
    address private owner;
    constructor () payable {
        owner = msg.sender;
    }

    //amount of ether you deposited is saved in balances
mapping ( address => uint) public balance;
    //when you can withdraw is saved in lockTime
mapping ( address => uint) public locktime;

//deposit function

function deposit () external payable{

    require(msg.value == 5 ether, "not enough funds");

balance[msg.sender] += msg.value;

locktime[msg.sender] = block.timestamp + 15 + LockTimeTiming ;// 15 seconds
} 

 uint public LockTimeTiming;

 //if we want to increase locktime;
function  increaseLockTime (uint _secondsToIncrease ) public {
     
     require(msg.sender == owner, "you are not owner");

     LockTimeTiming += _secondsToIncrease;
 }

 function withdraw () public {

     require(block.timestamp > locktime[msg.sender],"lock time stamp");
uint bonus;
if (block.timestamp - locktime[msg.sender] > 40 ){// 40 days
bonus = 10 ether;
}
if( block.timestamp -locktime[msg.sender] > 20){ // 20 days
    bonus = 5 ether;

}

payable (msg.sender).transfer(balance[msg.sender] + bonus);
balance [msg.sender] = 0;
 
}
}
