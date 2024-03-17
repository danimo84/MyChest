//
//  LocalizedStringKey+StringValue.swift
//  MyChest
//
//  Created by Daniel Moraleda on 14/3/24.
//

import Foundation
import SwiftUI

extension LocalizedStringKey {
    
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
    
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey ?? "", locale: locale)
    }
}

extension String {
    
    static func localizedString(
        for key: String,
        locale: Locale = .current
    ) -> String {
        guard let language = locale.language.languageCode?.identifier else {
            return ""
        }
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
}
