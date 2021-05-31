pragma solidity >=0.6.0 <0.7.0;
//SPDX-License-Identifier: MIT

//import "hardhat/console.sol";

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//learn more: https://docs.openzeppelin.com/contracts/3.x/erc721

// GET LISTED ON OPENSEA: https://testnets.opensea.io/get-listed/step-two
// clean reserve stuff....

contract YourCollectible {

  event Minted(uint256 indexed tokenId, uint256 indexed pricePaid, uint256 indexed reserveAfterMint);
  event Burned(uint256 indexed tokenId, uint256 indexed priceReceived, uint256 indexed reserveAfterBurn);


  // Curve Code: One function sets the mint price; the other sets the burn price
  // Since we work with integers, we can simply use a summation (instead of an integral) for burn pricing

  uint256 total = 0;
  uint256 maxMint = 5;
  // Curve Pricing Vars
  uint256 public initMintPrice = 1 ether;
  uint256 public incrementPrice = 1 ether;

  function mint() public virtual payable returns (uint256) {

    uint256 mintPrice = getCurrentPriceToMint();
    require(total < maxMint, "No more NFTSs to be minted!");
    require(msg.value >= mintPrice, "Not enough ETH sent; check price!");

    total = total + 1;
  }

  function burn() public virtual returns (uint256) {

    require(total >= 0, "Cannot go negative!");
    uint256 burnPrice = getCurrentPriceToBurn();
    msg.sender.transfer(burnPrice);
    total = total - 1;
  }

  // Linear Pricing Function With Minimal Gas Usage and Arthimetic Series Formulas
  // S_n = (n/2)(x_1+x_n)
  // Using the arithmetic sum formula, we are able to appropriately use a closed formula equation to
  // price each individual NFT

  // Sets mintPrice
  function getCurrentPriceToMint() public virtual view returns (uint256) {
    if (total ==0) {
      return(initMintPrice);
    }

    else {
      uint256 mintPrice = (total+1)*(incrementPrice);
      return (mintPrice);
    }
  }

  // Sets burnPrice
  function getCurrentPriceToBurn() public virtual view returns (uint256) {
    if (total ==0) {
      return(0);
    }

    else {
      uint256 burnPrice = ((address(this).balance/summation(total))*total);
      return (burnPrice);
      }
  }

  // Summation used for burnPrice calculations
  function summation(uint256 x) public virtual pure returns(uint256) {
      return x*(x+1)/2;
  }

  /*
  // ------ Uncomment below and re-deploy contract for alternative pricing mechanism------

  // Expodential Pricing Function With Minimal Gas Usage and Geometric Series Formulas
  // S_n = a(r^n-1)/(r-1)
  // Sample pricing function of (0.5*2^n)
  // a = 0.5
  // r = 2
  // n = 5 [Note that maxMint = 5]

  // Note that with geometric series, we can also build more complex closed form solutions
  // for other multi-term expressions

  uint256 public initMintPrice = 1 ether;
  // Sets mintPrice
  function getCurrentPriceToMint() public virtual view returns (uint256) {
      uint256 mintPrice = (2**total)*10**18;
      uint256 price = mintPrice/2;
      return (price);
  }

  // Sets burnPrice
  function getCurrentPriceToBurn() public virtual view returns (uint256) {
    if (total ==0) {
      return(0);
    }

    else {
      uint256 burnPrice = (summation(total));
      return (burnPrice);
      }
  }

  function summation(uint256 x) public virtual pure returns(uint256) {
      uint256 price = ((2**(x-1)))*10**18;
      return price/(2*(2-1));
  }
  */
}
