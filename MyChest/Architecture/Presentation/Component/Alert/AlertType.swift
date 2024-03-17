//
//  AlertType.swift
//  MyChest
//
//  Created by Daniel Moraleda on 14/3/24.
//

import Foundation

enum AlertType {
    
    case genericError
    case deleteConfirmation
    case inputData
    
    var title: String {
        switch self {
        case .genericError:
            Strings.Alert.genericErrorTitle.stringValue()
        case .deleteConfirmation:
            Strings.Alert.deleteAccountTitle.stringValue()
        case .inputData:
            Strings.Alert.addYourImageTitle.stringValue()
        }
    }
    
    var message: String {
        switch self {
        case .genericError:
            Strings.Alert.genericErrorMessage.stringValue()
        case .deleteConfirmation:
            Strings.Alert.deleteAccountMessage.stringValue()
        case .inputData:
            Strings.Alert.addYourImageMessage.stringValue()
        }
    }
    
    var dismissButtonTitle: String {
        switch self {
        case .genericError:
            Strings.GeneralActions.accept.stringValue()
        case .deleteConfirmation:
            Strings.GeneralActions.cancel.stringValue()
        case .inputData:
            Strings.GeneralActions.accept.stringValue()
        }
    }
    
    var confirmButtonTitle: String {
        switch self {
        case .deleteConfirmation:
            Strings.GeneralActions.delete.stringValue()
        case .inputData:
            Strings.GeneralActions.accept.stringValue()
        default:
            "not_key_configured"
        }
    }
    
    var placeholder: String {
        switch self {
        case .inputData:
            Strings.Alert.addYourImagePlaceholder.stringValue()
        default:
            "not_key_configured"
        }
    }
}
