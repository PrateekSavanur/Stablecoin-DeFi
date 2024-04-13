# Decentralized Stablecoin (DSC) System

This is a decentralized stablecoin system inspired by MakerDAO's DAI stablecoin. The system consists of two main contracts: `DecentralizedStableCoin` and `DSCEngine`.

## DecentralizedStableCoin Contract

The `DecentralizedStableCoin` contract is an ERC20 token that represents the stablecoin itself. It inherits from the `ERC20Burnable` and `Ownable` contracts from OpenZeppelin. Only the owner of this contract, which is the `DSCEngine` contract, can mint or burn tokens.

## DSCEngine Contract

The `DSCEngine` contract is the core of the system and manages the minting, burning, and collateralization of the stablecoin. Here's how it works:

1. **Collateral Deposit**: Users can deposit supported ERC20 tokens as collateral into the system using the `depositCollateral` function. The supported tokens and their corresponding price feed addresses are specified during the contract's construction.

2. **Minting DSC**: After depositing collateral, users can mint DSC tokens using the `mintDsc` function. The amount of DSC minted must be overcollateralized with the deposited collateral to maintain a minimum health factor (200% by default).

3. **Redeeming Collateral**: Users can redeem their deposited collateral by burning the corresponding amount of DSC tokens using the `redeemCollateralForDSC` function.

4. **Liquidation**: If a user's health factor falls below the minimum threshold (1 by default), their position can be partially or fully liquidated by others. The `liquidate` function allows users to burn a portion of the undercollateralized user's DSC tokens and receive their collateral, along with a bonus, as compensation.

The `DSCEngine` contract also provides various getter functions to retrieve information about user balances, collateral values, and system parameters.

## Flow

1. User deposits supported ERC20 tokens as collateral using `depositCollateral`.
2. User mints DSC tokens by calling `mintDsc`, which requires them to maintain a minimum health factor.
3. User can redeem their collateral by burning DSC tokens using `redeemCollateralForDSC`.
4. If a user's health factor falls below the minimum threshold, their position can be liquidated by others using the `liquidate` function.

## Key Features

- Overcollateralized system: Users must maintain a minimum health factor to mint DSC tokens.
- Liquidation mechanism: Undercollateralized positions can be partially or fully liquidated by others.
- Supported collateral tokens: The system supports multiple ERC20 tokens as collateral, specified during contract deployment.
- Price feed integration: The system uses Chainlink price feeds to determine the USD value of the collateral tokens.


# Stablecoin

1. Relative Stability : Anchored or pegged -> 1$
   1. Chainlink Price feed
   2. Set a fxn to ETH/BTC -> $
2. Stability mechanism (Minting) : Algorithmic (Decentralized)
   1. People can only mint only using enough collateral
3. Collateral : Exogenous (Crypto)
   1. wETH
   2. wBTC
   
