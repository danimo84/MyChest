//
//  AppDelegate+SwfitData.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/1/24.
//

import Foundation

extension AppDelegate {
    
    func swiftDataStorage() {
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
}
