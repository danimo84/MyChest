//
//  Strings.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import Foundation
import SwiftUI

enum Strings {
    
    enum MainScreen {
        
        static let notificationsTab: LocalizedStringKey = "Tabbar_Notifications"
        static let accountsTab: LocalizedStringKey = "Tabbar_Accounts"
        static let settingsTab: LocalizedStringKey = "Tabbar_Settings"
        static let loginButton: LocalizedStringKey = "Locked_LoginButton"
    }
    
    enum AccountsScreen {
        
        static let title: LocalizedStringKey = "Accounts_NavigationTitle"
        static let deletableButton: LocalizedStringKey = "Accounts_DeletableButton"
    }
    
    enum AccountDetailScreen {
        
        static let domainSectionHeader: LocalizedStringKey = "AccountDetail_DomainSection_Header"
        static let domainSectionPlaceholder: LocalizedStringKey = "AccountDetail_DomainSection_Placeholder"
        static let userSectionHeader: LocalizedStringKey = "AccountDetail_UserSection_Header"
        static let userSectionPlaceholder: LocalizedStringKey = "AccountDetail_UserSection_Placeholder"
        static let passwordSectionHeader: LocalizedStringKey = "AccountDetail_PasswordSection_Header"
        static let passwordSectionPlaceholder: LocalizedStringKey = "AccountDetail_PasswordSection_Placeholder"
        static let passwordSectionGenerateButton: LocalizedStringKey = "AccountDetail_PasswordSection_GenerateButton"
        static let notesSectionTitle: LocalizedStringKey = "AccountDetail_NotesSection_Title"
        static let rememberUpdatePasswordTitle: LocalizedStringKey = "AccountDetail_RememberUpdatePassword_Title"
        static let rememberUpdatePasswordNever: LocalizedStringKey = "AccountDetail_RememberUpdatePassword_Never"
        static let newAccountDetailTitle: LocalizedStringKey = "AccountDetail_NewAccountTitle"
        static let accountDetailTitle: LocalizedStringKey = "AccountDetail_AccountTitle"
        static let passwordGeneratorTitle: LocalizedStringKey = "AccountDetail_PasswordGeneratorTitle"
        static let lastPasswordUpdatedDate: LocalizedStringKey = "AccountDetail_LastPasswrodUpdatedDate"
        
        static func rememberUpdatePasswordByMonth(monthsNumber: Int) -> LocalizedStringResource {
            LocalizedStringResource(
                "AccountDetail_RememberUpdatePassword_ByMonth",
                defaultValue: "Each \(monthsNumber) month"
            )
        }
        
        static func rememberUpdatePasswordByMonths(monthsNumber: Int) -> LocalizedStringResource {
            LocalizedStringResource(
                "AccountDetail_RememberUpdatePassword_ByMonths",
                defaultValue: "Each \(monthsNumber) months"
            )
        }
    }
    
    enum SettingsScreen {
        
        static let informationTitle: LocalizedStringKey = "Settings_InformationTitle"
        static let notificationsTitle: LocalizedStringKey = "Settings_NotificationsTitle"
        static let generalHeader: LocalizedStringKey = "Settings_GeneralHeader"
        static let title: LocalizedStringKey = "Settings_title"
        static let defaultConfigButtonTitle: LocalizedStringKey = "Settings_DefaultConfigButtonTitle"
    }
    
    enum ProfileScreen {
        
        static let profileTitle: LocalizedStringKey = "Profile_Title"
        static let getNewUserButtonTitle: LocalizedStringKey = "Profile_GetNewUserButtonTitle"
        static let streetPlacehoder: LocalizedStringKey = "Profile_StreetPlacehoder"
        static let numberPlacehoder: LocalizedStringKey = "Profile_NumberPlacehoder"
        static let postcodePlacehoder: LocalizedStringKey = "Profile_PostcodePlacehoder"
        static let cityPlacehoder: LocalizedStringKey = "Profile_CityPlacehoder"
        static let statePlacehoder: LocalizedStringKey = "Profile_StatePlacehoder"
        static let countryPlacehoder: LocalizedStringKey = "Profile_CountryPlacehoder"
        static let editAddressButtonTitle: LocalizedStringKey = "Profile_EditAddressButtonTitle"
        static let editAddressTitle: LocalizedStringKey = "Profile_EditAddressTitle"
    }
    
    enum NotificationsScreen {
        
        static let title: LocalizedStringKey = "Notifications_title"
        static let emptyState: LocalizedStringKey = "Notifications_EmptyState"
        
        static let passwordUpdateTitle: String = NSLocalizedString("Notifications_PasswordUpdateTitle", comment: "")
        
        static func passwordUpdateBody(domain: String, monthsNumber: Int) -> String {
            String(
                format: NSLocalizedString("Notifications_PasswordUpdateBody", comment: ""),
                domain,
                monthsNumber
            )
        }
    }
    
    enum Alert {
        
        static let addYourImageTitle: LocalizedStringKey = "Alert_AddYourImageTitle"
        static let addYourImagePlaceholder: LocalizedStringKey = "Alert_AddYourImagePlaceholder"
        static let addYourImageMessage: LocalizedStringKey = "Alert_AddYourImageMessage"
        
        static let deleteAccountTitle: LocalizedStringKey = "Alert_DeleteAccountTitle"
        static let deleteAccountMessage: LocalizedStringKey = "Alert_DeleteAccountMessage"
        
        static let genericErrorTitle: LocalizedStringKey = "Alert_GenericErrorTitle"
        static let genericErrorMessage: LocalizedStringKey = "Alert_GenericErrorMessage"
    }
    
    enum GeneralActions {
        
        static let accept: LocalizedStringKey = "GeneralActions_Accept"
        static let cancel: LocalizedStringKey = "GeneralActions_Cancel"
        static let ok: LocalizedStringKey = "GeneralActions_Ok"
        static let delete: LocalizedStringKey = "GeneralActions_Delete"
    }
    
    enum PasswordGenerator {
        
        static let charactersNumberTitle: LocalizedStringKey = "PasswordGenerator_CharactersNumberTitle"
        static let upperTitle: LocalizedStringKey = "PasswordGenerator_UpperTitle"
        static let lowerTitle: LocalizedStringKey = "PasswordGenerator_LowerTitle"
        static let numbersTitle: LocalizedStringKey = "PasswordGenerator_NumbersTitle"
        static let specialCharsTitle: LocalizedStringKey = "PasswordGenerator_SpecialCharsTitle"
        static let header: LocalizedStringKey = "PasswordGenerator_Header"
    }
    
    enum Toolbar {
        
        static let saveButton: LocalizedStringKey = "Toolbar_SaveButton"
        static let delteButton: LocalizedStringKey = "Toolbar_DeleteBotton"
        static let cancelButton: LocalizedStringKey = "Toolbar_CancelButton"
    }
}
