//
//  GeneratePasswordInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 11/4/24.
//

import XCTest
import SwiftyMocky
@testable import MyChest

final class GeneratePasswordInteractorUnitTests: XCTestCase {

    // Class
    var passwordEntintyAllActive: String!
    var passwordEntintyUpperActive: String!
    var passwordEntintyUpperLowerActive: String!
    var passwordEntintyUpperLowerNumberActive: String!
    var configEntityAllActive: ConfigEntity!
    var configEntityUpperActive: ConfigEntity!
    var configEntityUpperLowerActive: ConfigEntity!
    var configEntityUpperLowerNumberActive: ConfigEntity!
    var generatePasswordInteractor: GeneratePasswordInteractorDefault!
    
    // Mock
    var passwordGeneratorManager: PasswordGeneratorManagerMock!
    
    override func setUp() {
        super.setUp()
        buildMocks()
        buildClass()
    }
    
    func test_execute_success_all() async {
        // Given
        Given(passwordGeneratorManager, .generatePasswordWithConfig(Parameter<ConfigEntity>.value(configEntityAllActive), willReturn: passwordEntintyAllActive))
        
        // When
        let result = generatePasswordInteractor.execute(ConfigMapper.map(configEntityAllActive))
        
        // Then
        XCTAssertEqual(result.count, configEntityAllActive.charactersNumber)
    }
    
    func test_execute_success_upper() async {
        // Given
        Given(passwordGeneratorManager, .generatePasswordWithConfig(.value(configEntityUpperActive), willReturn: passwordEntintyUpperActive))
        
        // When
        let result = generatePasswordInteractor.execute(ConfigMapper.map(configEntityUpperActive))
        
        // Then
        XCTAssertEqual(result.count, configEntityUpperActive.charactersNumber)
        XCTAssertTrue(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.letters.uppercased())))
        XCTAssertFalse(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.letters)))
        XCTAssertFalse(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.numbers)))
        XCTAssertFalse(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.special)))
    }
    
    func test_execute_success_upper_lower() async {
        // Given
        Given(passwordGeneratorManager, .generatePasswordWithConfig(.value(configEntityUpperLowerActive), willReturn: passwordEntintyUpperLowerActive))
        
        // When
        let result = generatePasswordInteractor.execute(ConfigMapper.map(configEntityUpperLowerActive))
        
        // Then
        XCTAssertEqual(result.count, configEntityUpperActive.charactersNumber)
        XCTAssertTrue(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.letters.uppercased())))
        XCTAssertTrue(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.letters)))
        XCTAssertFalse(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.numbers)))
        XCTAssertFalse(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.special)))
    }
    
    func test_execute_success_upper_lower_number() async {
        // Given
        Given(passwordGeneratorManager, .generatePasswordWithConfig(.value(configEntityUpperLowerNumberActive), willReturn: passwordEntintyUpperLowerNumberActive))
        
        // When
        let result = generatePasswordInteractor.execute(ConfigMapper.map(configEntityUpperLowerNumberActive))
        
        // Then
        XCTAssertEqual(result.count, configEntityUpperActive.charactersNumber)
        XCTAssertTrue(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.letters.uppercased())))
        XCTAssertTrue(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.letters)))
        XCTAssertTrue(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.numbers)))
        XCTAssertFalse(passwordContains(result, charsSet: CharacterSet(charactersIn: Theme.PasswordGenerator.special)))
    }
}

private extension GeneratePasswordInteractorUnitTests {
    
    func buildMocks() {
        passwordGeneratorManager = PasswordGeneratorManagerMock()
    }
    
    func buildClass() {
        generatePasswordInteractor = GeneratePasswordInteractorDefault(passwordGeneratorManager: passwordGeneratorManager)
        configEntityAllActive = allActiveConfig()
        configEntityUpperActive = upperActiveConfig()
        configEntityUpperLowerActive = upperLowerActiveConfig()
        configEntityUpperLowerNumberActive = upperLowerNumberActiveConfig()
        passwordEntintyAllActive = "Qwerty_190123456"
        passwordEntintyUpperActive = "QQQQQQQQQQQQQQQQ"
        passwordEntintyUpperLowerActive = "Qwertyqwertyqwer"
        passwordEntintyUpperLowerNumberActive
        = "Qwertyr190123456"
        
        Matcher.default.register(ConfigEntity.self) { (lhs, rhs) -> Bool in
            guard lhs.requireUpper == rhs.requireUpper, lhs.requireLower == rhs.requireLower, lhs.requireNumber == rhs.requireNumber, lhs.requireSpecialCharacter == rhs.requireSpecialCharacter, lhs.charactersNumber == rhs.charactersNumber else { return false }
        return true
        }
    }
    
    func allActiveConfig() -> ConfigEntity {
        ConfigEntity(
            id: "0000-1111",
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: true,
            storeInKeyChain: false,
            areNotificationsEnabled: true
        )
    }
    
    func upperActiveConfig() -> ConfigEntity {
        ConfigEntity(
            id: "0000-1111",
            charactersNumber: 16,
            requireUpper: true,
            requireLower: false,
            requireNumber: false,
            requireSpecialCharacter: false,
            storeInKeyChain: false,
            areNotificationsEnabled: true
        )
    }
    
    func upperLowerActiveConfig() -> ConfigEntity {
        ConfigEntity(
            id: "0000-1111",
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: false,
            requireSpecialCharacter: false,
            storeInKeyChain: false,
            areNotificationsEnabled: true
        )
    }
    
    func upperLowerNumberActiveConfig() -> ConfigEntity {
        ConfigEntity(
            id: "0000-1111",
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: false,
            storeInKeyChain: false,
            areNotificationsEnabled: true
        )
    }
}

private extension GeneratePasswordInteractorUnitTests {
    
    func passwordContains(_ password: String, charsSet: CharacterSet) -> Bool {
        guard let _ = password.rangeOfCharacter(from: charsSet) else {
            return false
        }
        return true
    }
}
