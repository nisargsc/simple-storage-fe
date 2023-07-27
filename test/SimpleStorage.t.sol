// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";
import {ISimpleStorage} from "../src/ISimpleStorage.sol";

contract SimpleStorageTest is Test, ISimpleStorage {
    SimpleStorage public simpleStorage;
    address simpleStorageOwner;
    address addr1;
    address addr2;

    function setUp() public {
        simpleStorage = new SimpleStorage();
        simpleStorageOwner = address(this);
        addr1 = vm.addr(1);
        addr2 = vm.addr(2);
    }

    // Deployment tests //
    function test_rightOwner() public {
        assertEq(simpleStorage.owner(), simpleStorageOwner);
    }

    function test_defaultFavNum() public {
        assertEq(simpleStorage.favoriteNumber(), 0);
    }

    // Validation tests //
    function test_UnauthorizedError() public {
        vm.expectRevert(Unauthorized.selector);
        vm.prank(addr2);
        simpleStorage.store(5);
    }

    // Events tests //
    function test_NumberStoredEvent() public {
        // 1. Expect to emit event and tell foundry what to check for
        vm.expectEmit(true,false,false,false, address(simpleStorage));

        // 2. Emit event to tell foundry which event to check with
        emit NumberStored(5);
        
        // 3. Make the function call that emits the event
        simpleStorage.store(5);
    }

    function test_PersonAddedEvent() public {
        vm.expectEmit(true,false,false,false, address(simpleStorage));
        emit PersonAdded("Person", 5);
        simpleStorage.addPerson("Person", 5);
    }

    // FavoriteNumber tests //
    function test_retrieveInitialValue()  public {
        assertEq(simpleStorage.retrieve(), 0);
    }

    function test_store()  public {
        simpleStorage.store(5);
    }


    function test_retrieve()  public {
        simpleStorage.store(5);
        assertEq(simpleStorage.retrieve(), 5);
    }

    // Person tests //
    function test_addPerson()  public {
        simpleStorage.addPerson("Person", 5);
    }

    function test_nameToFavoriteNumber()  public {
        simpleStorage.addPerson("Person", 5);
        assertEq(simpleStorage.nameToFavoriteNumber("Person"), 5);
    }
}
