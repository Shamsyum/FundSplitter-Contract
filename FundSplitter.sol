pragma solidity 0.5.11;

    // Splitting mony from one account into two accuounts equall.

contract Splitter{ 
    
    mapping(address => uint)balance;
    
    function splitFund(address payable  _address1, address payable _address2)public payable{ 
        
        uint remainder = msg.value % 2;
        uint half = msg.value/2;
        if(remainder == 1 wei){
            
        half = (msg.value - 1) / 2;
        
        //Send 1 wei back to the invocker
        msg.sender.transfer(1 wei); 
        
        //Half of the total amount passed 
        _address1.transfer(half);
        _address2.transfer(half);
        
        }else{
            
        //Half of the total amount passed
        _address1.transfer(half);
        _address2.transfer(half); 
       
        }
    }
}
