module 0x1::DogNFT { 
  use sui::object::{Self, UID}; 
  use sui::transfer; use sui::url::{Self, Url}; 
  use sui::tx_context::{Self, TxContext};
  const MAX_SUPPLY: u64 = 100;
  const ELimitExceeded: u64 = 1;
  struct SomeDogNFT has key, store 
  { id: UID, n: u64, url: Url 
  
  }
  struct NftCap has key { id: UID, issued_counter: u64, }
  fun init(ctx: &mut TxContext) 
  { 
    let minting_cap = NftCap { id: object::new(ctx), issued_counter: 0, }; 
    transfer::transfer(minting_cap, tx_context::sender(ctx)) 
  }
    public fun mint(cap: &mut NftCap, url: vector<u8>, receiver: address, ctx: &mut TxContext) 
    {
        let n = cap.issued_counter; cap.issued_counter = n + 1; 
        assert!(n <= MAX_SUPPLY, ELimitExceeded); 
        let nft = SomeDogNFT 
        { id: object::new(ctx), n: n, url: url::new_unsafe_from_bytes(url) }; 
        transfer::transfer(nft, receiver); 
    } 
    
}