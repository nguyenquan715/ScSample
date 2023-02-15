// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IAccessControl {
  event RoleAdminChanged(bytes32 role, bytes32 previousAdminRole, bytes32 newAdminRole);
  event RoleGranted(bytes32 role, address account, address sender);
  event RoleRevoked(bytes32 role, address account, address sender);

  function hasRole(bytes32 role, address account) external view returns (bool);
  function getRoleAdmin(bytes32 role) external view returns (bytes32);
  function grantRole(bytes32 role, address account) external;
  function revokeRole(bytes32 role, address account) external;
  function renounceRole(bytes32 role, address account) external;
}