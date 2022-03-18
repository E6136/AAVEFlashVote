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

    /*Inside of the flashVote function,
    we call the flashloan function on the pool and borrow 100k DAI (borrowAmount).*/
    function flashVote() external {
        address[] memory assets = new address[](1);
        assets[0] = address(DAI);

        uint[] memory amounts = new uint[](1);
        amounts[0] = borrowAmount;

        uint[] memory modes = new uint[](1);
        modes[0] = 0;
    
        pool.flashLoan(address(this), assets, amounts, modes, address(this), "", 0);
    
    }

    /*When we kick off an AAVE flash loan in the flashVote function,
    this will callback executeOperation function.
    
    We want to make sure that this flash loan executes successfully,
    then we have to repay the loan amount plus the premiums for those loans.*/
    function executeOperation(
        address[] calldata,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address, bytes calldata
    ) external returns(bool) {

        uint totalOwed = amounts[0] + premiums[0];
        DAI.approve(address(pool), totalOwed);

        return true;
    }
}