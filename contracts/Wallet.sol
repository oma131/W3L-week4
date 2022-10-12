// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Wallet{
    //state variable for the owner
    address payable public owner;

    mapping(address => uint) public balances;

    //Initialize events that gets emitted after Key operations
    event Stored (uint timestamp, address sender, uint amount);
    //event Withdraw (uint timestamp, address sender, uint amount);
    event SendEther (uint timestamp, address sender, address reciever, uint amount);

    //Initaialization code to set the owners address
    constructor() {
        owner = payable(msg.sender);
    }

    // Modifier that enables only the owner of the Smart contract to carry out certain transactions
    modifier onlyOwner {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    // Modifier that enables only the user of the Smart contract to carry out certain transactions
    modifier onlyUser(uint amount) {
        require(balances[msg.sender] >= amount, "Not enough funds");
        _;
    }

    // The 'receive' function allows our smart contract to recieve ether
    receive() external  payable {
        balances[msg.sender] += msg.value;
        emit Stored (block.timestamp, msg.sender, msg.value);
    }

    // This function allows the owner to send or transfer ether
    function sendEther(address payable _reciever, uint _amount) onlyUser(_amount) public payable {
        balances[_reciever] += _amount;
        balances[msg.sender] -= _amount;
        emit SendEther(block.timestamp, msg.sender, _reciever, msg.value);
    }


    function getBalance() external view returns(uint){
        return address(this).balance;
    }


}