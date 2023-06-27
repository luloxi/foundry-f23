// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract SimpleStorage {
    // favoriteNumber gets initialized to 0 if no value is given
    
    // If no visibility is specified, defaults to internal
    uint256 public myFavoriteNumber; // default value is 0

    // uint256[] listOfFavoriteNumbers; // [3, 77, 19]
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // dynamic array
    Person[] public listOfPeople; // []

    mapping(string => uint256) public nameToFavoriteNumber;

    // Person public myFriend = Person(7, "Pat");
    // Person public myFriend = Person({favoriteNumber: 7, name: "Pat"});

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    } 

    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}