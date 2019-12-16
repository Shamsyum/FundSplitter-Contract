pragma solidity ^0.5.0;

//Contract to transfer equall ether to two accounts.
contract fundSender{ 
    
    function transferFund(address payable  _Address1, address payable _Address2)public payable{ 
        
       // at least one ether should be passed when invoking the function.
        require(msg.value >= 1 ether); 
        
        _Address1.transfer(msg.value/2); //Half of the total amount passed 
        _Address2.transfer(msg.value/2); //Half of the total amount passed
        
    }
    
}