// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract  Vote is Ownable {
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }
    struct Proposal {
        string description;
        uint256 voteCount;
    }
    enum etat {
        register,
        closeregister,
        vote,
        closevote
    }
    struct Session {
        etat etat;
        bool isPublicProposal;
        Proposal[] lesProposition;
    }

    Proposal newPorosal;
    Voter currentVote = Voter(false,false,0);
    Vote.Session currentSession;
    Proposal winner;
    
    address[] whitelist;
    event newProposition(Proposal);
    event etatSession(Session);
   
    
    

    function startSession(bool _publicProposal) public onlyOwner pure{
        currentSession.etat=etat.register;
        currentSession.isPublicProposal=_publicProposal;
        emit etatSession(currentSession);
    }

    function closeProposition() public onlyOwner pure{
        require(currentSession.etat==etat.register,"Session need be in register status before");
        currentSession.etat = etat.closeregister;
        emit etatSession(currentSession);
    }
    function openVote() public onlyOwner pure {
        require(currentSession.etat==etat.closeregister,"Session need be in closeregister status before");
        currentSession.etat = etat.vote;
        emit etatSession(currentSession);
    }
    function closeVote() public onlyOwner pure {
        require(currentSession.etat==etat.vote,"Session need be in vote status before");
        currentSession.etat = etat.closevote;
        emit etatSession(currentSession);
    }

    function setVote(uint _ProposalId) public{
        require(FindInWhiteList(msg.sender) && currentSession.etat==etat.vote &&!currentVote.hasVoted );
        currentSession.lesProposition[_ProposalId].voteCount+=1;
        currentVote.hasVoted=true;
        
    }
    function proposer(string calldata _description ) public {
        if(currentSession.isPublicProposal || _checkOwner()){
            require(
                FindInWhiteList(msg.sender) && currentSession.etat == etat.register
            );
            newPorosal = Proposal(_description, 0);
            currentSession.lesProposition.push(newPorosal);
            emit newProposition(newPorosal);
        }
    }

    function contabiliserVote()public onlyOwner  view{
        uint i=1;
        uint max =currentSession.lesProposition[0].voteCount;
        winner=currentSession.lesProposition[0];
        for (i; i < currentSession.lesProposition.length ; i++) {
           if(max > currentSession.lesProposition[i].voteCount){
                max=currentSession.lesProposition[i].voteCount;
                winner=currentSession.lesProposition[i];
           }
        }
        
    }
     function getSession()public view returns (Vote.Session calldata){
        return currentSession;
    }
    function getWinner()public view  returns(Proposal calldata){
        return winner;
    }
}