// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./interface/IAccessControl.sol";

contract AccessControl is IAccessControl {
  mapping(bytes32 => mapping(address => bool)) roleOfUsers;
  mapping(bytes32 => bytes32) adminRoles;
  bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

  modifier onlyRole(bytes32 role) {
    _checkRole(role);
    _;
  }

  function hasRole(bytes32 role, address account) public view virtual override returns (bool) {
    return roleOfUsers[role][account];
  }

  function getRoleAdmin(bytes32 role) public view virtual override returns (bytes32) {
    return adminRoles[role];
  }

  function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {    
    _grantRole(role, account);
  }

  function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
    _revokeRole(role, account);
  }

  function renounceRole(bytes32 role, address account) public virtual override {
    require(account == msg.sender, "AccessControl: can only renounce roles for self");
    _revokeRole(role, account);
  }

  function _checkRole(bytes32 role) internal view virtual {
    _checkRole(role, msg.sender);
  }

  function _checkRole(bytes32 role, address account) internal view virtual {
    if (!hasRole(role, account)) {
      revert(string(abi.encodePacked("AccessControl: account ", Strings.toHexString(account)," is missing role ",Strings.toHexString(uint256(role), 32))));
    }
  }

  function _setupRole(bytes32 role, address account) internal virtual {
    _grantRole(role, account);
  }

  function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
    bytes32 previousAdminRole = getRoleAdmin(role);   
    adminRoles[role] = adminRole;
    emit RoleAdminChanged(role, previousAdminRole, adminRole);
  }

  function _grantRole(bytes32 role, address account) internal virtual {
    require(account != address(0), 'Invalid address');
    if (!hasRole(role, account)) {
      roleOfUsers[role][account] = true;
      emit RoleGranted(role, account, msg.sender);
    }
  }

  function _revokeRole(bytes32 role, address account) internal virtual {
    if (hasRole(role, account)) {
        roleOfUsers[role][account] = false;
        emit RoleRevoked(role, account, msg.sender);
    }
  }
}