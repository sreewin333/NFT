# An NFT that is completely stored on chain.

This is an NFT that is sompletely stored on chain without using ipfs.The NFT image can be switched between two Car logo's lamborghini or ferrari.

## Installation

Install foundry

```bash
 curl -L https://foundry.paradigm.xyz | bash

```

## Run Locally

Clone the project

```bash
 https://github.com/sreewin333/NFT.git
```

Go to the project directory

```bash
  cd NFT/
```

Install dependencies

```bash
forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

```

## Deployment

To deploy the NFT, first run anvil on terminal

```bash
 anvil
```

Deploy the NFT Locally on anvil

```bash
forge script script/DeployMyNft.s.sol:DeployMyNft --rpc-url 127.0.0.1:8545 --private-key "use a private key from anvil" --broadcast
```

Mint the NFT

```bash
forge script script/MintAndFlip.s.sol:MintNft --rpc-url 127.0.0.1:8545 --private-key "use the deployed private key" --broadcast
```

Flip the Image of the NFT

```bash
forge script script/MintAndFlip.s.sol:FlipNft --rpc-url 127.0.0.1:8545 --private-key "use the deployed private key" --broadcast
```

!!! If you are planning to add this NFT to you metamask,after flip you may have to re-add the nft to be able to see the flipped image

## Running Tests

To run tests, run the following command

```bash
forge test
```
