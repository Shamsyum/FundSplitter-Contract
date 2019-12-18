pragma solidity ^0.5.0;

    // Splitting mony from one account into two accuounts equall.

contract Splitter{ 
    
    function splitFund(address payable  _address1, address payable _address2)public payable{ 
        require(msg.value % 2 == 0 wei);
        _address1.transfer(msg.value/2); //Half of the total amount passed 
        _address2.transfer(msg.value/2); //Half of the total amount passed
        
    }
    
}