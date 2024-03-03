//
//  StorageManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/1/24.
//

import Foundation

// MARK: - StorageManager imp

final class StorageManager {
    
    static var shared: StorageManager = .init()
    
    @StorageEntry(key: .areNotificationsEnabled, emptyValue: false)
    var areNotificationsEnabled: Bool
    
    @StorageEntry(key: .accountIdToNavigate, emptyValue: nil)
    var accountIdToNavigate: String?
    
    enum Keys: String, CaseIterable {
        case areNotificationsEnabled
        case accountIdToNavigate
    }
}

// MARK: - StorageManager clear data

extension StorageManager {
    
    func clearKeys(_ keys: Keys...) {
        keys.forEach { UserDefaultsManager.shared.clear($0) }
    }
    
    func clearAll() {
        UserDefaultsManager.shared.clearAll()
    }
    
    func clearPendingNavigations() {
        clearKeys(.accountIdToNavigate)
    }
}

// MARK: - Property Wrappers

extension StorageManager {
    
    @propertyWrapper
    struct StorageEntry<Value: Codable> {
        let key: StorageManager.Keys
        let emptyValue: Value
        
        var wrappedValue: Value {
            get { UserDefaultsManager.shared.get(key) ?? emptyValue }
            set { try? UserDefaultsManager.shared.save(newValue, withKey: key) }
        }
    }
}

// MARK: - UserDefaults Manager

private final class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
    
    func save(_ data: some Encodable, withKey key: StorageManager.Keys) throws {
        guard let data = try? JSONEncoder().encode(data) else { throw DataError.encoding }
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    func get<T: Decodable>(_ key: StorageManager.Keys) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue)
        else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func clear(_ key: StorageManager.Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func clearAll() {
        StorageManager.Keys.allCases.forEach { clear($0) }
    }
}
