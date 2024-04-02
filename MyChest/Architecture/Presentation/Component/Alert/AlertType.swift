//
//  AlertType.swift
//  MyChest
//
//  Created by Daniel Moraleda on 14/3/24.
//

import Foundation

enum AlertType {
    
    case genericError
    case customError(title: String? = nil, message: String)
    case deleteConfirmation(_ type: DeleteConfirmationType)
    case inputData(_ type: InputDataType)
    
    var title: String {
        switch self {
        case .genericError:
            Strings.Alert.genericErrorTitle.stringValue()
        case .customError(let title, _):
            if let title {
                title
            } else {
                Strings.Alert.genericErrorTitle.stringValue()
            }
        case .deleteConfirmation(let type):
            switch type {
            case .account:
                Strings.Alert.deleteAccountTitle.stringValue()
            }
        case .inputData(let type):
            switch type {
            case .domain:
                Strings.Alert.addYourImageTitle.stringValue()
            }
        }
    }
    
    var message: String {
        switch self {
        case .genericError:
            Strings.Alert.genericErrorMessage.stringValue()
        case .customError(_, let message):
            message
        case .deleteConfirmation(let type):
            switch type {
            case .account:
                Strings.Alert.deleteAccountMessage.stringValue()
            }
        case .inputData(let type):
            switch type {
            case .domain:
                Strings.Alert.addYourImageMessage.stringValue()
            }
        }
    }
    
    var dismissButtonTitle: String {
        switch self {
        case .genericError, .inputData, .customError(_, _):
            Strings.GeneralActions.accept.stringValue()
        case .deleteConfirmation:
            Strings.GeneralActions.cancel.stringValue()
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
        case .inputData(let type):
            switch type {
            case .domain:
                Strings.Alert.addYourImagePlaceholder.stringValue()
            }
        default:
            "not_key_configured"
        }
    }
}

enum DeleteConfirmationType {
    
    case account
}

enum InputDataType {
    
    case domain
}
