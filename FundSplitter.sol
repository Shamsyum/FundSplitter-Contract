pragma solidity 0.5.11;

    // Splitting mony from one account into two accounts equally.

contract Splitter{ 
    
    mapping(address => uint)balance;
    address[] addresses;
    modifier canWithdraw(){
        for(uint i=0; i<addresses.length; i++){
            if(addresses[i] == msg.sender && balance[address(msg.sender)] > 0){
                _;
            }
            
        }
    }
    function splitFund(address payable  _address1, address payable _address2)public payable{ 
        
        uint remainder = msg.value % 2;
        uint half = msg.value/2;
        
        if(remainder == 1 wei){
            
        half = (msg.value - 1) / 2;
        
        //If the amount passed odd in wei
        //Send 1 wei back to the invocker
        msg.sender.transfer(1 wei); 
        
        balance[_address1] = half;
        balance[_address2] = half;
        addresses.push(_address1);
        addresses.push(_address2);
        }else{
            
        
        balance[_address1] = half;
        balance[_address2] = half; 
        addresses.push(_address1);
        addresses.push(_address2);
        }
    }
    
    //By this function, the fund owners will get their funds, associated with their address 
    function withdrawFund()public payable canWithdraw{
                msg.sender.transfer(balance[address(msg.sender)]);
                balance[address(msg.sender)] = 0;
                
    }
}
