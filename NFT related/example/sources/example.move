module example::puppy {
    use std::string::String;
    use sui::event;
    use sui::object::{UID, ID};
    use sui::tx_context::TxContext;
    use sui::balance;
    use sui::address;
    use sui::transfer;
    
    const MAX_NFTS: u64 = 1000;
    const ADMIN_ADDRESS: address = @0x9b8c355fcabf85b85921e0069aa66b2f71e669ae4e7214519c43009f1240e88d; // Replace with Puneet's actual address

    /// An example NFT that can be minted by anybody. A Puppy is
    /// a freely-transferable object. Owner can add new traits to
    /// their puppy at any time and even change the image to the
    /// puppy's liking. 
    public struct Puppy has key, store {
        id: UID,
        /// Name of the Puppy
        name: String,
        /// Grumpy or chill?
        traits: vector<String>,
        /// The URL of the Puppy's image
        url: String,
        /// Grade of the Puppy (1, 2, 3, or 4)
        grade: u8,
    }


    public struct PuppyMinted has copy, drop {
        puppy_id: ID,
        minted_by: address,
    }

    public struct MintState has key {
        id: UID,
        count: u64,
    }


    /// Mint a new Puppy with the given `name`, `traits`, `url`, and `grade`.
    /// The object is returned to sender and they're free to transfer
    /// it to themselves or anyone else.
       public fun mint(
        state: &mut MintState,
        name: String,
        traits: vector<String>,
        url: String,
        grade: u8,
        ctx: &mut TxContext
    ): Puppy {
        assert!(state.count < MAX_NFTS, 0);
        
        let minter_balance = balance::value(self:);
        assert!(minter_balance > 100, 1);
        state.count =  state.count + 1 ;

        let id = object::new(ctx);

        event::emit(PuppyMinted {
            puppy_id: id.to_inner(),
            minted_by: ctx.sender(),
        });

        Puppy { id, name, traits, url, grade }
    }

    /// Some puppies get new traits over time... owner of one can
    /// add a new trait to their puppy at any time.
    public fun add_trait(puppy: &mut Puppy, trait: String) {
        puppy.traits.push_back(trait);
    }

    /// As the puppy grows, owners can change the image to reflect
    /// the puppy's current state and look.
    public fun set_url(puppy: &mut Puppy, url: String) {
        puppy.url = url;
    }

    /// Admin can transfer a Puppy NFT to another address.
    public fun admin_transfer(puppy: &mut Puppy, to: address) {
        assert!(ctx.sender() == ADMIN_ADDRESS, 2);
        transfer::transfer(puppy, to);
    }

    /// It's a good practice to allow the owner to destroy the NFT
    /// and get a storage rebate. Not a requirement and depends on
    /// your use case. At last, who doesn't love puppies?
    public fun destroy(puppy: Puppy) {
        let Puppy { id, url: _, name: _, traits: _, grade: _ } = puppy;
        id.delete()
    }

    // Getters for properties.
    // Struct fields are always private and unless there's a getter,
    // other modules can't access them. It's up to the module author
    // to decide which fields to expose and which to keep private.

    /// Get the Puppy's `name`
    public fun name(puppy: &Puppy): String { puppy.name }

    /// Get the Puppy's `traits`
    public fun traits(puppy: &Puppy): &vector<String> { &puppy.traits }

    /// Get the Puppy's `url`
    public fun url(puppy: &Puppy): String { puppy.url }

    /// Get the Puppy's `grade`
    public fun grade(puppy: &Puppy): u8 { puppy.grade }
}
