# MyChest

This app born only with learning purposes. Basically, provide the capability to store account credentials and manage it.

More specifically we could enumerate following features:
* Creation, edition and deletion of account.
* Store account info like: domain, user, password, reminder to update passwords and notes. The account screen provide opotion to add manually a url image or detect link metadata using account domain.
* Password generator with capability to configure allowed characters and number of them.
* User is notificated when require new password update.
* Historic of notifications received section.
* Settings section

## 🧑🏻‍💻 Tecnical information

* VIPER + CLEAN 🏛️
* Dependency injection
* SwiftUI
* Combine
* SwiftData
* Local Notifications
* Biometric auth
* Unit Tests with `SwiftyMocky`
* UI Tests with `SnapshotTesting`
* Localization for Spanish and English
* Light/Dark mode
* Link url metadata - get metadata from account domain and if retrieve image sets for account.

## 🛠 Created with 

* Xcode 15.2
* iOS 17
* Cocoapods 1.15.2
* Swift Package Manger
  
## ▶️ Steps to build 

* Run `pod install` to install project dependencies.
* Open MyChest.xcworkspace.
* Targets to build:
  
  * Run Application -> Target `MyChest`
  * Run Unit Tests -> Target `MyChestUnitTests`
  * Run UI Tests -> Target `MyChestUITests`
 
## 🚀 Next steps

- [ ] Store encrypted password
- [ ] Database versioning
- [ ] Visual component to show security lever for each account password
- [ ] Complete UITests with alerts states

