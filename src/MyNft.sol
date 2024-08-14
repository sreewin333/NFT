// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MyNft is ERC721 {
    uint256 private s_tokenCounter;
    string private LamborghiniSvgImageUri;
    string private FerrariSvgImageUri;

    mapping(uint256 => FavBrand) private s_tokenIdToImageUri;

    enum FavBrand {
        lamborghini,
        ferrari
    }

    constructor(string memory lamborghinisvgimageURI, string memory ferrariSvgimageURI) ERC721("MyNFT", "MNFT") {
        s_tokenCounter = 0;
        LamborghiniSvgImageUri = lamborghinisvgimageURI;
        FerrariSvgImageUri = ferrariSvgimageURI;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToImageUri[s_tokenCounter] = FavBrand.ferrari;
        s_tokenCounter++;
    }

    function flipBrand(uint256 tokenid) public {
        address owner = _ownerOf(tokenid);
        _checkAuthorized(owner, msg.sender, tokenid);
        if (s_tokenIdToImageUri[tokenid] == FavBrand.lamborghini) {
            s_tokenIdToImageUri[tokenid] = FavBrand.ferrari;
        } else {
            s_tokenIdToImageUri[tokenid] = FavBrand.lamborghini;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenid) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToImageUri[tokenid] == FavBrand.lamborghini) {
            imageUri = LamborghiniSvgImageUri;
        } else {
            imageUri = FerrariSvgImageUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        name(),
                        '", "description":"An NFT that can change between a lamborghini or a ferrari", ',
                        '"attributes": [{"trait_type": "HOT", "value": 100}], "image":"',
                        imageUri,
                        '"}'
                    )
                )
            )
        );
    }
}
