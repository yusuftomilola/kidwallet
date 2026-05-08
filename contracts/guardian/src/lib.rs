#![no_std]
pub mod error;
use soroban_sdk::{contract, contractimpl, Env};

#[contract]
pub struct GuardianContract;

#[contractimpl]
impl GuardianContract {
    // Guardian policy management and child spending enforcement.
    // Full implementation in subsequent commits.
}

#[cfg(test)]
mod tests {
    use super::*;
    use soroban_sdk::Env;

    #[test]
    fn contract_instantiates() {
        let env = Env::default();
        let _id = env.register_contract(None, GuardianContract);
    }
}
