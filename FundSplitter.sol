pragma solidity 0.6.0;

    // Splitting mony from one account into two accounts equally.

contract Splitter{
    
    mapping(address => uint) public balances;
    event FundSplitted(address sender, address address1, address address2, uint value);
    event WithdrawDone(address sender, uint amount);
    address private owner;
    
    constructor()public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner, "caller is not the owner");
        _;
    }
    
     //This will split the provided value into two parts and transfer to two addresses equally
    function splitFund(address payable  _address1, address payable _address2)public payable{ 
        emit FundSplitted(msg.sender, _address1, _address2, msg.value);
        uint remainder = msg.value % 2;
        uint half = msg.value/2;
        balances[_address1] += half;
        balances[_address2] += half;
        if(remainder > 0){
            msg.sender.transfer(1 wei);
        }
    }    
    
    //By this function, everyone who has funds in the contract can withdraw it
    function withdrawFund(uint _amount)public returns(bool) {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        emit WithdrawDone(msg.sender, _amount);
        msg.sender.transfer(_amount);
        return true;
    }
    
    //This will remove the contract and transfer all the funds in the contract to the owner
    function kill() public onlyOwner returns(bool){
        selfdestruct(msg.sender);
        return true;
    }
}
