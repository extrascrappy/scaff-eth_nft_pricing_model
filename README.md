# 🏗 scaffold-eth- NFT Pricing Through Arthimetic / Geometric Summation Closed-Form Equations

>   Sample pricing functions for NFT bonding curves using linear arthimetic summation and
expodential geometric summation.  Features low gas methods for calculating prices and gives the
basic mathematical formulas that can be combined and arranged to form most polynomial summations
allowing for semi-complex bonding curve pricing without the complex, gas intensive contracts of
the Bancor protocol
---

Linear Pricing Function With Minimal Gas Usage and Arthimetic Series Formulas
=> S_n = (n/2)(x_1+x_n)

Expodential Pricing Function With Minimal Gas Usage and Geometric Series Formulas
=> S_n = a(r^n-1)/(r-1)

Note that these two closed form equations can be used to represent more complex multi-term polynomials
allowing for complex pricing equations in a closed-form manner; meaning that users are charged minimal
gas since no gas is spent on storage or recursive calls

git clone the scaffold-eth repository.....

```bash
cd scaffold-eth_nft_pricing
yarn install

```

```bash
yarn start

```

> in a second terminal window:

```bash
cd scaffold-eth_nft_pricing
yarn chain

```

> in a third terminal window:

```bash
cd scaffold-eth_nft_pricing
yarn deploy

```

🔏 Edit your smart contract `YourCollectible.sol` in `packages/hardhat/contracts` to comment out / uncomment out the desired pricing function you want to experiment with

📱 Open http://localhost:3000 to see the app

---
