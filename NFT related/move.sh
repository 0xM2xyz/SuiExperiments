sui move build
  sui client new-env --alias devnet --rpc https://fullnode devnet.sui.io:443
  sui client switch --env devnet
  sui client publish --gas-budget 100000000 . --skip-dependency-verification
sui client call --function mint --module DogNFT --package 0x481b4fada2fe099ed5672a49cd40fc610f4de025c80573f8cb8986c9687699a2  --args 0x410c8115d11ac47b4c299ec7bb067023646d6a9a4dc2c87d37aa4ed38cbf7526 "https://res.cloudinary.com/daily-now/image/upload/t_logo,f_auto/v1655817725/logos/community" 0x9b8c355fcabf85b85921e0069aa66b2f71e669ae4e7214519c43009f1240e88d  --gas-budget 10000
