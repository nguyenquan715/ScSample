// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../interface/ERC20/IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {
  string private _name;
  string private _symbol;
  uint8 private _decimals;
  uint256 private _totalSupply;

  mapping(address => uint256) balances;  

  constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
  }

  function name() external view returns (string memory) {
    return _name;
  }

  function symbol() external view returns (string memory) {
    return _symbol;
  }

  function decimals() external view returns (uint8) {
    return _decimals;
  }

  function totalSupply() external view returns (uint256) {
    return _totalSupply;
  }
}