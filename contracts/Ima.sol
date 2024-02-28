// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Ima is ERC721 {
    constructor() ERC721("Ima", "IMA") {
    }
}
