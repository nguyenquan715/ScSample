// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "./interface/IAccessControlEnumerable.sol";
import "./AccessControl.sol";

contract AccessControlEnumerable is IAccessControlEnumerable, AccessControl {
  using EnumerableSet for EnumerableSet.AddressSet;

  mapping(bytes32 => EnumerableSet.AddressSet) private _roleMembers;

  function getRoleMember(bytes32 role, uint256 index) public view virtual override returns (address) {
    return _roleMembers[role].at(index);
  }

  function getRoleMemberCount(bytes32 role) public view virtual override returns (uint256) {
    return _roleMembers[role].length();
  }

  function _revokeRole(bytes32 role, address account) internal virtual override {
    super._revokeRole(role, account);
    _roleMembers[role].remove(account);
  }

  function _grantRole(bytes32 role, address account) internal virtual override {
    super._grantRole(role, account);
    _roleMembers[role].add(account);
  }
}