
module xm_0::xm_0 {
    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    const MAX_SUPPLY: u64 = 500;
    const ETooManyNums: u64 = 0;

    public struct NumIssuerCap has key {
        id: UID,
        supply: u64,
        issued_counter: u64,
    }

    public struct DevNetNFT has key, store {
        id: UID,
        description: string::String,
        ranking: u64,
        grade: u64,
    }
    


    public struct MintNFTEvent has copy, drop {
        object_id: ID,
        creator: address,
        description: string::String,
        ranking: u64,
        grade: u64,
    }

    #[allow(unused_function)]
    fun init(ctx: &mut TxContext) {
        let issuer_cap = NumIssuerCap {
            id: object::new(ctx),
            supply: 0,
            issued_counter: 0,
        };
        transfer::transfer(issuer_cap, tx_context::sender(ctx));
        // Commented out this line as we are transferring issuer_cap to the sender
        // transfer::share_object(issuer_cap);  // <-- UNCHANGED: This allows anyone to access the capability
    }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        let issuer_cap = NumIssuerCap {
            id: object::new(ctx),
            supply: 0,
            issued_counter: 0,
        };
        transfer::transfer(issuer_cap, tx_context::sender(ctx));
        // Commented out this line as we are transferring issuer_cap to the sender
        // transfer::share_object(issuer_cap);  // <-- UNCHANGED: This allows anyone to access the capability
    }
    
    /// Create a new devnet_nft
    public entry fun mint(
        cap: &mut NumIssuerCap,
        description: vector<u8>,
        grade: u64,
        ctx: &mut TxContext
    ) {
        assert!(cap.supply < MAX_SUPPLY, ETooManyNums);  // <-- ADDED: Check supply before minting
        let n = cap.issued_counter;
        cap.issued_counter = n + 1;
        cap.supply = cap.supply + 1;

            let devNftId = object::new(ctx);
            let nft = DevNetNFT {
            id: devNftId,
            description: string::utf8(description),
            grade: grade,
            ranking: n
        };
        let sender = tx_context::sender(ctx);
        let object_id = object::uid_to_inner(&nft.id);
        event::emit(MintNFTEvent {
            object_id: object_id,
            creator: sender,
            description: string::utf8(description),
            grade: grade,
            ranking: n
        });
        transfer::public_transfer(nft, sender);
               
    }
    

    public entry fun mint_and_transfer(
        cap: &mut NumIssuerCap,
        description: vector<u8>,
        grade: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        assert!(cap.supply < MAX_SUPPLY, ETooManyNums);  // <-- ADDED: Check supply before minting
        let n = cap.issued_counter;
        cap.issued_counter = n + 1;
        cap.supply = cap.supply + 1;

        let nft = DevNetNFT {
            id: object::new(ctx),
            description: string::utf8(description),
            grade: grade,
            ranking: n
        };
        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            description: string::utf8(description),
            grade: grade,
            ranking: n
        });
        transfer::transfer(nft, recipient);

        // transfer::public_transfer(nft, sender);
    }
    

    /// Permanently delete `nft`
    public entry fun burn(nft: DevNetNFT) {
        let DevNetNFT { id,  description: _,  ranking:_, grade:_ } = nft;
        object::delete(id);
    }

    /// Transfer `nft` to `recipient`
    public entry fun transfer_nft(nft: DevNetNFT, recipient: address) {
        transfer::transfer(nft, recipient);
    }


    /// Transfer `NumIssuerCap` to `recipient`
    public entry fun transfer_issuer_cap(cap: NumIssuerCap, recipient: address) {
        transfer::transfer(cap, recipient);
    }
}
