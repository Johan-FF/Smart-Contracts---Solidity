// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./ImaDNA.sol";

contract Ima is ERC721, ERC721Enumerable, ImaDNA {
    uint256 private _counterId;
    uint256 public maxSupply;

    constructor(uint256 _maxSupply) ERC721("Ima", "IMA") {
        _counterId = 0;
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = _idCounter;
        require(current < maxSupply, "No Ima left");
        _idCounter++;
        _safeMint(msg.sender, current);
    }

    function tokenURI(uint256 tokenId) 
        public 
        view 
        override 
        returns(string memory)
    {
        require(_exists(tokenId), "ERC721 Metadata: URI query for nonexistent token");
        string memory jsonURI = encode(abi.encodePacked(
            '{"name": "Ima #', 
            tokenId, 
            '", "description": "Ima Marketplace", "image": "',
            '// TODO: Calculate image url',
            '"}' 
        ));

        return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}