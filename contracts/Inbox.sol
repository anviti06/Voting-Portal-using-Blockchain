pragma solidity ^0.4.21;

contract Election{
    /*Fields For a Candidate */
    struct Candidate{
        string name;
        uint voteCount;
    }    
    
    /* Fields For a Voter */
    struct Voter{
        bool authorized;
        bool voted;
        uint32 choice;
    }
    
    address public electionCommission;
    mapping(address=>Voter) VotersList;
    Candidate[] public candidates;
    
    uint public totalVotes;
    
    event voterAdded(address voter);
    event voteEnded(uint finalResult);
    event voteDone(address voter);
    
    modifier ownerOnly(){
        require(msg.sender == electionCommission); 
        _;
    }
    
    function costructor() public {
        electionCommission = msg.sender;
    }
    
    //Functions of Election Commision
    
    function addCandidate(string _name) ownerOnly public {
        candidates.push(Candidate( _name , 0));
    }
    
    function authorize(address _person) ownerOnly public{
        VotersList[_person].authorized = true; 
        emit voterAdded( _person);
    }
    
    function getNumCandidate() public view returns(uint) {
        return candidates.length;
    }
    
    
    
    function vote(uint32 _voteIndex) public {
        require(!VotersList[msg.sender].voted);         //Checking that voter has already not voted
        require(VotersList[msg.sender].authorized);     //Checking if the voter is authorized to vote
        
        VotersList[msg.sender].choice = _voteIndex;
        VotersList[msg.sender].voted = true;
        
        candidates[_voteIndex].voteCount +=1;
        totalVotes +=1;
        
        emit voteDone( msg.sender);
        
    }
    
    //Gives the final result of the Election
    function Result() ownerOnly public view returns (string){
        uint mx = 0; string memory name;
        for(uint i = 0 ; i <candidates.length ; i++){
            if(candidates[i].voteCount > mx){
                mx = candidates[i].voteCount;
                name = candidates[i].name;
            }
        }
        return name;
    }
    
    
    
    
    
}
