pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./TRC20.sol";
import "./TRC20Detailed.sol";
import "./TRC20Burnable.sol";
import "./TRC20Pausable.sol";

contract TicketToken is Ownable,TRC20,TRC20Detailed,TRC20Burnable,TRC20Pausable {
    using SafeMath for uint256;

    //10500000
    constructor(uint256 totalSupply) TRC20Detailed("Ticket Token", "TIK", 0) public {
        _mint(msg.sender, totalSupply);
    }

    function batchTransfer(address[] memory _to, uint256[] memory _value) public whenNotPaused returns (bool) {
        require(_to.length > 0);
        require(_to.length == _value.length);
        uint256 sum = 0;
        for(uint256 i = 0; i< _value.length; i++) {
            sum = sum.add(_value[i]);
        }
        require(balanceOf(msg.sender) >= sum);
        for(uint256 k = 0; k < _to.length; k++){
            _transfer(msg.sender, _to[k], _value[k]);
        }
        return true;
    }
}
