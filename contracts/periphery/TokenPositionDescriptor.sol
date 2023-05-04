// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;


import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import '../interfaces/periphery/INonfungibleTokenPositionDescriptor.sol';

contract TokenPositionDescriptor is INonfungibleTokenPositionDescriptor, Ownable
{
    string private baseURI;

    function setBaseURI(string memory _baseURI) external onlyOwner {
        baseURI = _baseURI;
    }

    function tokenURI(IBasePositionManager, uint256 tokenId)
    external
    view
    override
    returns (string memory)
    {
        return
        bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI, Strings.toString(tokenId)))
        : '';
    }
}
