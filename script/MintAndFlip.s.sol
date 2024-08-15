// SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {MyNft} from "../script/DeployMyNft.s.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract MintNft is Script {
    function run() public {
        address recentlyDeployedContract = DevOpsTools.get_most_recent_deployment("MyNft", block.chainid);
        mintScript(recentlyDeployedContract);
    }

    function mintScript(address MyNftAddress) public {
        vm.startBroadcast();
        MyNft(MyNftAddress).mintNft();
        vm.stopBroadcast();
        MyNft.FavBrand currentBrand = MyNft(MyNftAddress).getbrand(0);
        console.log(uint256(currentBrand));
    }
}

contract FlipNft is Script {
    function run() public {
        uint256 tokenId = 0;
        address recentlyDeployedContract = DevOpsTools.get_most_recent_deployment("MyNft", block.chainid);
        ChangeBrand(recentlyDeployedContract, tokenId);
    }

    function ChangeBrand(address myNftAddress, uint256 tokenId) public {
        vm.startBroadcast();
        MyNft(myNftAddress).flipBrand(tokenId);
        vm.stopBroadcast();
        MyNft.FavBrand flippedBrand = MyNft(myNftAddress).getbrand(tokenId);
        console.log(uint256(flippedBrand));
    }
}
