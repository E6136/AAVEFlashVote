// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

import "./Govern.sol";
import "./ILendingPool.sol";

contract FlashVoter {
    ILendingPool constant pool = ILendingPool(0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9);
    IERC20 constant DAI = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);

    uint constant borrowAmount = 100000e18;

    Govern public governanceToken;
    uint public proposalId;

    constructor(Govern _governanceToken, uint _proposalId) {
        
        governanceToken = _governanceToken;
        
        proposalId = _proposalId;
    
    }

    function flashVote() external {
        
    }

    function executeOperation(
        address[] calldata,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address, bytes calldata
    ) external returns(bool) {
        
    }
}


