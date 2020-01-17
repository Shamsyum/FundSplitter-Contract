 pragma solidity 0.5.11;

    // Splitting mony from one account into two accounts equally.

contract Splitter{
    
    mapping(address => uint) public balances;
    event logSplitFund(address, address);
    event logWithdraw(address, uint);
     
    function splitFund(address payable  _address1, address payable _address2)public payable{ 
        
        uint remainder = msg.value % 2;
        uint half = msg.value/2;
        
        if(remainder == 1 wei){
            
        half = (msg.value - 1) / 2;
        
        //If the amount passed odd in wei
        //Send 1 wei back to the invocker
        msg.sender.transfer(1 wei); 
        balances[_address1] = half;
        balances[_address2] = half;
        emit logSplitFund(_address1, _address2);
        }else{
        
        //If the amount is even
        balances[_address1] = half;
        balances[_address2] = half; 
        emit logSplitFund(_address1, _address2);
        }
    }
    
    //By this function, every Fund owner can withdraw their funds by theirself
    function withdrawFund(uint _amount)public returns(bool) {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        msg.sender.transfer(_amount);
        emit logWithdraw(msg.sender, _amount);
        return true;
    }
}