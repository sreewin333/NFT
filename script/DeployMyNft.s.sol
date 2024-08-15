// SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {MyNft} from "../src/MyNft.sol";
import {Script} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMyNft is Script {
    function run() public returns (MyNft) {
        string memory lambosvg = vm.readFile("./images/lamborghini.svg");
        string memory ferrarisvg = vm.readFile("./images/ferrari.svg");
        vm.startBroadcast();
        MyNft mynft = new MyNft(svgtoimageURi(lambosvg), svgtoimageURi(ferrarisvg));
        vm.stopBroadcast();
        return mynft;
    }

    function svgtoimageURi(string memory svg) public pure returns (string memory) {
        string memory front_part = "data:image/svg+xml;base64,";
        string memory encodedsvg = Base64.encode(bytes(abi.encodePacked(svg)));
        string memory encodedimageuri = string(abi.encodePacked(front_part, encodedsvg));
        return encodedimageuri;
    }
}
