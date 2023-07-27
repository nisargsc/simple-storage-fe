// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {ISimpleStorage} from "./ISimpleStorage.sol";

/**
 * @title Simple Storage
 */
contract SimpleStorage is ISimpleStorage {
    // State Variables //
    address public owner;
    uint256 public favoriteNumber;

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    // Modifiers //
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        _;
    }

    // Functions //

    constructor() {
        owner = msg.sender;
    }

    /**
     * Store 'favoriteNumber'
     * @param _favoriteNumber The new value to sotre
     * @dev This is a contract level state variable 'favoriteNumber'
     * @dev Only the owner can call this function
     */
    function store(uint256 _favoriteNumber) public onlyOwner {
        favoriteNumber = _favoriteNumber;
        emit NumberStored(_favoriteNumber);
    }

    /**
     * Retrieve 'favoriteNumber'
     * @return _favoriteNumber The stored favoriteNumber
     */
    function retrieve() public view returns (uint256 _favoriteNumber) {
        return favoriteNumber;
    }

    /**
     * Add Person
     * @param _name Name of the Person
     * @param _favoriteNumber FavoriteNumber of the Person
     * @dev This is a public function, hence anyone can add a Person
     */
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
        emit PersonAdded(_name, _favoriteNumber);
    }
}
