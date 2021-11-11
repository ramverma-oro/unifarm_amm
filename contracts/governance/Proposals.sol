pragma solidity =0.5.16;

import "../Ownable.sol";
import '../BaseRelayRecipient.sol';
import '../libraries/SafeMath.sol';

contract Proposals is Ownable, BaseRelayRecipient {

    using SafeMath for uint256;

    // blacklist mapping
    mapping(address => bool) public allowedList;
    
    // user address => proposalId => NumberofForVotes
    mapping(address => mapping(uint256 => uint256)) votes;

    event TokenPermitted(
        address allowAddress
    );

    modifier isAllowed(address _tokenAddress){
        require(allowedList[_tokenAddress], "NOTALLOWED_ERR: address is not allowed");
        _;
    }

    function updateTokenPermission(address _allowAddress, bool _tokenPermit) external onlyOwner() {
        allowedList[_allowAddress] = _tokenPermit;
        emit TokenPermitted(_allowAddress);
    }

    function _updateForVotes(uint256 _proposalId, uint256 _token) internal {
        votes[_msgSender()][_proposalId] = votes[_msgSender()][_proposalId].add(_token);
    }
}