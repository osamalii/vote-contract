// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract  Voting is Ownable(msg.sender) {
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
    Voting.Session currentSession;
    Proposal winner;
    mapping (address =>Voter) public whitelist;
    
    event newProposition(Proposal);
    event etatSession(Session);
    
    modifier isWhiteList {
        require( whitelist[msg.sender].isRegistered ,"is not whitelisted");
        _;
    }
    function addVoter(address _address)public onlyOwner() {
        require(!whitelist[_address].isRegistered);
        whitelist[_address]=Voter(true,false,0);
    }

    function startSession(bool _publicProposal) public onlyOwner {
        whitelist[owner()].isRegistered=true;
        currentSession.etat=etat.register;
        currentSession.isPublicProposal=_publicProposal;
        emit etatSession(currentSession);
    }

    function closeProposition() public onlyOwner {
        require(currentSession.etat==etat.register,"Session need be in register status before");
        currentSession.etat = etat.closeregister;
        emit etatSession(currentSession);
    }
    function openVote() public onlyOwner  {
        require(currentSession.etat==etat.closeregister,"Session need be in closeregister status before");
        currentSession.etat = etat.vote;
        emit etatSession(currentSession);
    }
    function closeVote() public onlyOwner  {
        require(currentSession.etat==etat.vote,"Session need be in vote status before");
        currentSession.etat = etat.closevote;
        emit etatSession(currentSession);
    }

    function setVote(uint _ProposalId) public{
        require(whitelist[msg.sender].isRegistered&& currentSession.etat==etat.vote &&!currentVote.hasVoted );
        currentSession.lesProposition[_ProposalId].voteCount+=1;
        currentVote.hasVoted=true;
        
    }
    function proposer(string calldata _description ) isWhiteList public {
        if(currentSession.isPublicProposal || owner()==msg.sender){
            require(
                currentSession.etat == etat.register
            );
            newPorosal = Proposal(_description, 0);
            currentSession.lesProposition.push(newPorosal);
            emit newProposition(newPorosal);
        }
    }

    function contabiliserVote()public onlyOwner {
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
     function getSession()public view returns (Voting.Session memory){
        return currentSession;
    }
    function getWinner()public view  returns(Proposal memory){
        return winner;
    }
}