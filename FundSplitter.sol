pragma solidity 0.5.11;

    // Splitting mony from one account into two accounts equally.

contract Splitter{
    
    mapping(address => uint) public balances;
    event FundSplitted(address sender, uint value , address address1, address address2);
    event WithdrawDone(address sender, uint amount);
     
    function splitFund(address payable  _address1, address payable _address2)public payable{ 
        emit FundSplitted(msg.sender,msg.value, _address1, _address2);
        uint remainder = msg.value % 2;
        uint half = msg.value/2;
        balances[_address1] += half;
        balances[_address2] += half;
        if(remainder > 0){
            msg.sender.transfer(1 wei);
        }
    }    
    
    //By this function, every Fund owner can withdraw their funds by theirself
    function withdrawFund(uint _amount)public returns(bool) {
        require(balances[msg.sender] >= _amount, 'Insufficient balance');
        balances[msg.sender] -= _amount;
        emit WithdrawDone(msg.sender, _amount);
        msg.sender.transfer(_amount);
        return true;
    }
}
