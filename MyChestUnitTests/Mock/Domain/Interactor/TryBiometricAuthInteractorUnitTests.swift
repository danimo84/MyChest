//
//  TryBiometricAuthInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 9/4/24.
//

import XCTest
import SwiftyMocky
@testable import MyChest

final class TryBiometricAuthInteractorUnitTests: XCTestCase {

    // Class
    var entity: Permission!
    var interactor: TryBiometricAuthInteractorDefault!
    
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
        Given(
            manager,
            .isPermissionGrantedAndRequested(
                forType:  Parameter<PermissionType>.value(.biometricAuth),
                willReturn: response
            )
        )
        
        // When
        let result = await interactor.execute()
        
        // Then
        XCTAssertEqual(result, entity.isAccepted)
    }
}

private extension TryBiometricAuthInteractorUnitTests {
    
    func buildMocks() {
        manager = PermissionsManagerMock()
    }
    
    func buildClass() {
        interactor = TryBiometricAuthInteractorDefault(permissionManager: manager)
        entity = Permission(
            isAccepted: true,
            wasRequested: true
        )
    }
}
