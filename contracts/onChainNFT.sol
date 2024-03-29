// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract IjayNft is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdToLevels;

    constructor() ERC721("OnChainNft", "OCNFT") {}

    function generateCharacter(
        uint256 tokenId
    ) public view returns (string memory) {
        bytes memory svg = abi.encodePacked(
        '<svg width="800px" height="800px" viewBox="0 0 1024 1024" class="icon"  version="1.1" xmlns="http://www.w3.org/2000/svg">'
        '<path d="M258 175.4c-9.2 0-16.6 7.5-16.6 16.6v638.1c0 15.9 12.9 28.7 28.7 28.7h483.8c15.9 0 28.7-12.9 28.7-28.7v-638c0-9.2-7.5-16.6-16.6-16.6H258z" fill="#68A240" />'
        '<path d="M753.9 864.4H270.1c-18.9 0-34.2-15.4-34.2-34.2V192.1c0-12.2 9.9-22.1 22.1-22.1h508c12.2 0 22.1 9.9 22.1 22.1v638.1c0 18.9-15.3 34.2-34.2 34.2zM258 180.9c-6.1 0-11.1 5-11.1 11.1v638.1c0 12.8 10.4 23.2 23.2 23.2h483.8c12.8 0 23.2-10.4 23.2-23.2v-638c0-6.1-5-11.1-11.1-11.1H258z" fill="#333336" />'
        '<path d="M668.4 358.5H355.6c-36.9 0-70.5-21.3-86.5-54.8l-27.2-116.3c-3.5-11 4.6-22.3 16.1-22.3h508c11.5 0 19.6 11.3 16.1 22.3l-27.2 116.3c-16 33.5-49.7 54.8-86.5 54.8z" fill="#FFD632" />'
        '<path d="M668.4 364H355.6c-19.1 0-37.8-5.4-54-15.7-16.2-10.3-29.2-24.9-37.5-42.2l-0.3-0.5-27.3-116.7c-2.1-6.9-0.9-14.2 3.3-20.1 4.3-5.9 10.9-9.2 18.1-9.2H766c7.2 0 13.8 3.4 18.1 9.2 4.3 5.9 5.5 13.2 3.3 20.1l-27.3 116.7-0.3 0.5c-8.3 17.4-21.3 32-37.5 42.2-16.1 10.3-34.8 15.7-53.9 15.7z m-394.1-62.1c15.1 31.1 47 51.1 81.3 51.1h312.7c34.3 0 66.2-20.1 81.3-51.1L776.8 186l0.1-0.2c1.2-3.6 0.5-7.4-1.7-10.5-2.2-3-5.5-4.7-9.2-4.7H258c-3.7 0-7 1.7-9.2 4.7-2.2 3-2.8 6.9-1.7 10.5l0.1 0.4 27.1 115.7z" fill="#333336" />'
        '<path d="M512.9 509.7h-1.7c-19 0-34.5-15.5-34.5-34.5V308.4c0-19 15.5-34.5 34.5-34.5h1.7c19 0 34.5 15.5 34.5 34.5v166.7c0 19.1-15.5 34.6-34.5 34.6z m-1.8-224.8c-13 0-23.5 10.5-23.5 23.5v166.7c0 13 10.5 23.5 23.5 23.5h1.7c13 0 23.5-10.5 23.5-23.5V308.4c0-13-10.5-23.5-23.5-23.5h-1.7z" fill="#333336" />'
        '<path d="M512 293.9m-40.2 0a40.2 40.2 0 1 0 80.4 0 40.2 40.2 0 1 0-80.4 0Z" fill="#D5D9CF" />'
        '<path d="M512 339.5c-25.2 0-45.7-20.5-45.7-45.7s20.5-45.7 45.7-45.7 45.7 20.5 45.7 45.7-20.5 45.7-45.7 45.7z m0-80.3c-19.1 0-34.7 15.6-34.7 34.7s15.6 34.7 34.7 34.7 34.7-15.6 34.7-34.7-15.6-34.7-34.7-34.7z" fill="#333336" />'
        '<path d="M512 293.9m-13.6 0a13.6 13.6 0 1 0 27.2 0 13.6 13.6 0 1 0-27.2 0Z" fill="#D5D9CF" />'
        '<path d="M512 312.9c-10.5 0-19.1-8.6-19.1-19.1s8.6-19.1 19.1-19.1 19.1 8.6 19.1 19.1-8.6 19.1-19.1 19.1z m0-27.1c-4.5 0-8.1 3.6-8.1 8.1s3.6 8.1 8.1 8.1 8.1-3.6 8.1-8.1-3.6-8.1-8.1-8.1z" fill="#333336" />'
        '<path d="M512 504.2m-40.2 0a40.2 40.2 0 1 0 80.4 0 40.2 40.2 0 1 0-80.4 0Z" fill="#D5D9CF" />'
        '<path d="M512 549.8c-25.2 0-45.7-20.5-45.7-45.7 0-25.2 20.5-45.7 45.7-45.7s45.7 20.5 45.7 45.7c0 25.2-20.5 45.7-45.7 45.7z m0-80.3c-19.1 0-34.7 15.6-34.7 34.7s15.6 34.7 34.7 34.7 34.7-15.6 34.7-34.7c0-19.2-15.6-34.7-34.7-34.7z" fill="#333336" />'
        '<path d="M541.9 574.2c-3 0-5.5-2.5-5.5-5.5v-31.2c0-3 2.5-5.5 5.5-5.5s5.5 2.5 5.5 5.5v31.2c0 3-2.5 5.5-5.5 5.5z" fill="#333336" />'
        '<path d="M512 503.7m-13.6 0a13.6 13.6 0 1 0 27.2 0 13.6 13.6 0 1 0-27.2 0Z" fill="#D5D9CF" />'
        '<path d="M512 522.7c-10.5 0-19.1-8.6-19.1-19.1s8.6-19.1 19.1-19.1 19.1 8.6 19.1 19.1-8.6 19.1-19.1 19.1z m0-27.1c-4.5 0-8.1 3.6-8.1 8.1s3.6 8.1 8.1 8.1 8.1-3.6 8.1-8.1-3.6-8.1-8.1-8.1z" fill="#333336" />'
        '<path d="M766.7 855.3c-2.4 0-4.7-1.6-5.3-4.1l-28.8-109c-3.2-12.3-14.3-20.8-27-20.8H320c-12.7 0-23.8 8.6-27 20.8l-28.8 109c-0.8 2.9-3.8 4.7-6.7 3.9-2.9-0.8-4.7-3.8-3.9-6.7l28.8-109c4.5-17.1 20-29 37.6-29h385.6c17.7 0 33.1 11.9 37.6 29l28.8 109c0.8 2.9-1 5.9-3.9 6.7-0.4 0.2-0.9 0.2-1.4 0.2z" fill="#333336" />'
        '<path d="M692.4 743.5H574.7l-5-69.2h127.8z" fill="#FFD632" />',
            getLevels(tokenId),
        '<path d="M697.5 749H569.6l-5.9-80.2h139.7l-5.9 80.2z m-117.6-11h107.5l4.3-58.2h-116l4.2 58.2z" fill="#333336" />'
        '<path d="M574.7 743.5v25.8h19.9l10.5-7.1 10.5 7.1h35.9l10.5-7.1 10.5 7.1h19.9v-25.8z" fill="#FFD632" />'
        '<path d="M697.9 774.8h-27.1l-8.8-5.9-8.8 5.9h-39.3l-8.8-5.9-8.8 5.9h-27.1V738h128.7v36.8z m-23.7-11H687V749H580.2v14.7H593l12.2-8.2 12.2 8.2H650l12.2-8.2 12 8.3z" fill="#333336" />'
        '<path d="M611.8 762.3l-11-0.6 6.5-114.1c-0.1-3.4-6.6-12.5-10.5-18-6.3-8.8-9.8-14.1-9.8-18.6 0-13.2 24.2-19.2 46.6-19.2 11.9 0 22.9 1.5 30.8 4.1 12.6 4.2 15.2 10.3 15.2 14.7 0 4.5-3.5 9.6-9.7 18.3-4.3 5.9-10.7 14.8-10.8 18.6l6.5 114.1-11 0.6-6.5-114.5v-0.2c0-7.3 6.5-16.4 12.9-25.2 2.8-3.9 7-9.7 7.6-11.8-1.1-2.4-12.3-7.8-35-7.8-21.9 0-33.9 5.7-35.6 8.3 0.7 2.3 4.9 8.2 7.7 12.1 7.6 10.6 12.5 18.1 12.5 24.4v0.3l-6.4 114.5z m-13.9-151.6z" fill="#333336" />'
        '</svg>');
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getLevels(uint256 tokenId) public view returns (string memory) {
        uint256 levels = tokenIdToLevels[tokenId];
        return levels.toString();
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "IJAY ONCHAIN NFT #',
            tokenId.toString(),
            '",',
            '"description": "Mint an On-Chain NFT",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdToLevels[newItemId] = 0;
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );
        uint256 currentLevel = tokenIdToLevels[tokenId];
        tokenIdToLevels[tokenId] = currentLevel + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}


