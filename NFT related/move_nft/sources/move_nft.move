module move_nft::move_nft {
    use 0x1::coin;
    use 0x1::sui::tx_context;
    use 0x1::sui::transfer;
    use 0x1::std::option;
    use 0x1::std::vector;
    use 0x1::url;

    const MAX_SUPPLY: u64 = 1000;
    const MINTING_REQUIREMENT: u64 = 10000;
    const NFT_DECIMALS: u8 = 9;

    struct NFT has key {
        id: u64,
        image_url: vector<u8>,
    }

    struct NFTCollection has key {
        nfts: vector<NFT>,
    }

    struct MintedNFTs has key {
        minted: bool,
    }

    public fun init(ctx: &mut tx_context::TxContext) {
        let sender = tx_context::sender(ctx);
        let collection = NFTCollection { nfts: vector::empty() };
        let minted = MintedNFTs { minted: false };
        create_and_transfer(sender, collection, ctx);
        create_and_transfer(sender, minted, ctx);
    }

    fun create_and_transfer<AssetType>(recipient: address, asset: AssetType, ctx: &mut tx_context::TxContext) {
        transfer::share_object(asset, ctx);
        transfer::transfer(recipient, asset, ctx);
    }
}
