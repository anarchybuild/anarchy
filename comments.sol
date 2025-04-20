// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract CommentToken is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Comment {
        address author;
        string content;
        uint256 timestamp;
    }

    mapping(uint256 => Comment) private _comments;

    event CommentCreated(
        uint256 indexed tokenId,
        address indexed author,
        string content,
        uint256 timestamp
    );

    constructor() ERC721("WebComment", "CMT") {}

    function createComment(string memory content) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        
        _safeMint(msg.sender, newTokenId);
        
        _comments[newTokenId] = Comment({
            author: msg.sender,
            content: content,
            timestamp: block.timestamp
        });

        emit CommentCreated(newTokenId, msg.sender, content, block.timestamp);
        return newTokenId;
    }

    function getComment(uint256 tokenId) public view returns (
        address author,
        string memory content,
        uint256 timestamp
    ) {
        require(_exists(tokenId), "Token does not exist");
        Comment memory comment = _comments[tokenId];
        return (comment.author, comment.content, comment.timestamp);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        
        Comment memory comment = _comments[tokenId];
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Comment #', Strings.toString(tokenId),
                        '", "description": "On-chain web comment stored as NFT",',
                        '"attributes": [',
                        '{"trait_type": "Author", "value": "', Strings.toHexString(comment.author), '"},',
                        '{"trait_type": "Timestamp", "display_type": "date", "value": ', Strings.toString(comment.timestamp), '},',
                        '{"trait_type": "Content", "value": "', _escapeJsonString(comment.content), '"}',
                        ']}'
                    )
                )
            )
        );
        
        return string(abi.encodePacked('data:application/json;base64,', json));
    }

    // Helper function to escape double quotes in JSON strings
    function _escapeJsonString(string memory str) private pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory buffer = new bytes(strBytes.length * 2);
        uint256 index;
        
        for (uint256 i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == '"') {
                buffer[index++] = '\\';
            }
            buffer[index++] = strBytes[i];
        }
        
        bytes memory result = new bytes(index);
        for (uint256 i = 0; i < index; i++) {
            result[i] = buffer[i];
        }
        
        return string(result);
    }
}