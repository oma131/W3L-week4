// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Wallet{
    //state variable for the owner
    address payable public owner;

    //Initaialization code to set the owners address
    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    // The 'receive' function allows our smart contract to recieve ether
    receive() external onlyOwner payable {}

    // This function allows the owner to send or transfer ether
    function sendEther(address payable _to, uint _amount) public payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        payable(msg.sender).transfer(_amount);
    }


    function getBalance() external view returns(uint){
        return address(this).balance;
    }


}