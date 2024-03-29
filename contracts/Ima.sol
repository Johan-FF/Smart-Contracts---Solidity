// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./ImaDNA.sol";

contract Ima is ERC721, ERC721Enumerable, ImaDNA {
    using Strings for uint256;

    uint256 private _counterId;
    uint256 public maxSupply;
    mapping(uint256 => uint256) public tokenDNA;

    constructor(uint256 _maxSupply) ERC721("Ima", "IMA") {
        _counterId = 0;
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = _counterId;
        require(current < maxSupply, "No Ima left");

        tokenDNA[current] = deterministicPseudoRandomDNA(current, msg.sender);
        _safeMint(msg.sender, current);
        _counterId+=1;
    }

    function _baseURI() 
        internal
        pure
        override
        returns (string memory)
    {
        return "https://getavataaars.com/";
    }

    function _paramsURI(uint256 _dna) 
        internal
        view
        returns (string memory)
    {
        string memory params;

        {
            params = string(abi.encodePacked(
                "accessoriesType=",
                getAccessoriesType(_dna),
                "&clotheColor=",
                getClotheColor(_dna),
                "&clotheType=",
                getClotheType(_dna),
                "&eyeType=",
                getEyeType(_dna),
                "&eyebrowType=",
                getEyeBrowType(_dna),
                "&facialHairColor=",
                getFacialHairColor(_dna),
                "&facialHairType=",
                getFacialHairType(_dna),
                "&hairColor=",
                getHairColor(_dna),
                "&hatColor=",
                getHatColor(_dna),
                "&graphicType=",
                getGraphicType(_dna),
                "&mouthType=",
                getMouthType(_dna),
                "&skinColor=",
                getSkinColor(_dna)
            ));
        }

        return string(abi.encodePacked(params,"&topType=",getTopType(_dna)));
    }

    function _exists(uint256 tokenId) 
        internal 
        view 
        returns (bool) 
    {
        return _ownerOf(tokenId) != address(0);
    }

    function imageByDNA(uint256 _dna) 
        public
        view
        returns (string memory)
    {
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);

        return  string(abi.encodePacked(baseURI, "?", paramsURI));
    } 

    function tokenURI(uint256 tokenId) 
        public 
        view 
        override 
        returns (string memory)
    {
        require(
            _exists(tokenId), 
            "ERC721 Metadata: URI query for nonexistent token"
        );

        uint256 dna = tokenDNA[tokenId];
        string memory image = imageByDNA(dna);

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{"name": "Ima #', 
                tokenId.toString(), 
                '", "description": "Ima Marketplace", "image": "',
                image,
                '"}'
            )
        );

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