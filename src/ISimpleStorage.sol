// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/**
 * @title Simple Storage
 */
contract ISimpleStorage {
    // Errors //

    /**
     * @notice Throw if unauthorized
     */
    error Unauthorized();

    // Events //

    /**
     * @notice Emitted when new number is added
     * @param favoriteNumber New value stored
     */
    event NumberStored(uint256 indexed favoriteNumber);

    /**
     * @notice Emitted when new Person is added
     * @param name Name of the Person
     * @param favoriteNumber FavoriteNumber of the Person
     */
    event PersonAdded(string indexed name, uint256 indexed favoriteNumber);

    // Structs //
    struct Person {
        uint256 favoriteNumber;
        string name;
    }
}