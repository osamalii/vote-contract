// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract WhiteList{
    
    address[] whiteList;
    address owner;
    
    constructor(){
        owner= msg.sender;
    }
    modifier isAdmin{
        require(msg.sender==owner);
        _;
    }
    function FindInWhiteList (address _findMe) public view returns(bool){
        if( _findMe== owner){
            return true;
        }
        uint i=0;
        for (i; i < whiteList.length ; i++) {
           if( _findMe == whiteList[i]){
                return true;
           }
        }
        return false;
    }

    function addWhiteToList(address _address) public  isAdmin {
        require(!FindInWhiteList(_address),"Is already in List");
        whiteList.push(_address);

    }
}