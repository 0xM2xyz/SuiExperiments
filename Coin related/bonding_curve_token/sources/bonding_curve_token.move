
module bonding_curve_token::BondingCurveToken {
    use sui::coin::{Self, Coin};
    use sui::math::{Self, U64};
    use std::account;
    use sui::transfer;
    use sui::balance;

    struct Token {
        supply: u64,
        price: u64, // price in SUI
        slope: u64,
        initial_price: u64,
    }

    public fun initialize_token(initial_supply: u64, slope: u64, initial_price: u64): Token {
        Token {
            supply: initial_supply,
            price: initial_price,
            slope: slope,
            initial_price: initial_price,
        }
    }

    public fun buy_tokens(token: &mut Token, amount: u64) acquires Coin {
        let total_cost = token.price * amount;
        let payment = account::withdraw_balance<SUI>(total_cost);

        token.supply = token.supply + amount;
        token.price = token.slope * token.supply + token.initial_price;
        transfer::deposit(payment, &account::address_of());
    }

    public fun sell_tokens(token: &mut Token, amount: u64) acquires Coin {
        assert!(token.supply >= amount, 0);

        let total_proceeds = token.price * amount;
        token.supply = token.supply - amount;
        token.price = token.slope * token.supply + token.initial_price;
        let payment = account::withdraw_balance<SUI>(total_proceeds);

        transfer::deposit(payment, &account::address_of());
    }

    public fun get_price(token: &Token): u64 {
        token.price
    }

    public fun get_balance(token: &Token, user: address): u64 acquires Coin {
        balance::balance<SUI>(user)
    }

    public fun direct_transfer(sender: address, recipient: address, amount: u64) acquires Coin {
        let sender_balance = balance::balance<SUI>(sender);
        assert!(sender_balance >= amount, 0);

        let coin = account::withdraw_balance<SUI>(amount);
        transfer::deposit(coin, recipient);
    }
}