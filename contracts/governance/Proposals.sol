pragma solidity =0.5.16;

import "../Ownable.sol";

contract Propasals is Ownable {
    // blacklist mapping
    mapping(address => bool) public allowedList;

    struct Vote {
        uint256 proposalId;
        mapping(address => mapping(uint8 => uint256)) voteMapping;
        address[] voters;
    }

    mapping(uint256 => Vote) _vote;

    event Allow(
        address allowAddress
    );

    event Voted(
        uint256 proposalId,
        address userAddress,
        uint8 support,
        uint256 token
    );

    modifier isAllowed(address _tokenAddress){
        require(!allowedList[_tokenAddress], "NOTALLOWED_ERR: address is not allowed");
        _;
    }

    function allow(address _allowAddress) external onlyOwner() {
        allowedList[_allowAddress] = true;
        emit Allow(_allowAddress);
    }

    // function createProposal(address tokenAddress, uint256 _totalDistribution) {
    //     // token distributed for the person who voted
    
    // }

    function voting(uint256 _proposalId, address _userAddress, uint8 _support, uint256 _token) external {
        _vote[_proposalId].proposalId = _proposalId;
        _vote[_proposalId].voteMapping[_userAddress][_support] = _token;
        _vote[_proposalId].voters.push(_userAddress);
        emit Voted(_proposalId, _userAddress, _support, _token);
    }
}