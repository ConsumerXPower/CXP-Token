// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@v4.9.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@v4.9.3/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts@v4.9.3/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts@v4.9.3/access/AccessControl.sol";

contract CXPToken is ERC20, ERC20Permit, ERC20Votes, AccessControl {
    bytes32 public constant TIMELOCK_ADMIN_ROLE = keccak256("TIMELOCK_ADMIN_ROLE");
    bytes32 public constant GOVERNOR_ROLE = keccak256("GOVERNOR_ROLE");

    string public whitepaperCID;
    event WhitepaperCIDUpdated(string newCID);

    constructor()
        ERC20("Consumer X Power", "CXP")
        ERC20Permit("Consumer X Power")
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(GOVERNOR_ROLE, msg.sender);
        _grantRole(TIMELOCK_ADMIN_ROLE, msg.sender);

        _mint(msg.sender, 8e9 * 10 ** decimals());
        whitepaperCID = "bafkreif22ianb5pxzw7jvued7ud4gdojx5gu3ocrbz6z6poo6zy2vevobi";
    }

    function updateWhitepaperCID(string memory newCID) public onlyRole(GOVERNOR_ROLE) {
        whitepaperCID = newCID;
        emit WhitepaperCIDUpdated(newCID);
    }

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._burn(account, amount);
    }
}
