//
//  UpdateNotificationPermissionInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 14/4/24.
//

import XCTest
import SwiftyMocky
@testable import MyChest

final class UpdateNotificationPermissionInteractorUnitTests: XCTestCase {

    // Class
    var entity: Permission!
    var interactor: UpdateNotificationPermissionInteractorDefault!
    
    // Mock
    var manager: PermissionsManagerMock!

    override func setUp() {
        super.setUp()
        buildMocks()
        buildClass()
    }
    
    func test_execute_success() async {
        // Given
        let response = entity!
        Given(manager, .isPermissionGrantedAndRequested(forType: Parameter<PermissionType>.value(.notifications), willReturn: response))
        
        // When
        let result = await interactor.execute(initialValue: true)
        
        // Then
        XCTAssertEqual(result, entity.isAccepted)
    }
}

private extension UpdateNotificationPermissionInteractorUnitTests {
    
    func buildMocks() {
        manager = PermissionsManagerMock()
    }
    
    func buildClass() {
        interactor = UpdateNotificationPermissionInteractorDefault(permissionManager: manager)
        entity = Permission(
            isAccepted: true,
            wasRequested: true
        )
    }
}
