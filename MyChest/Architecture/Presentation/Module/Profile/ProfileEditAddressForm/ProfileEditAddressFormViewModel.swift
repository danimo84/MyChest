//
//  ProfileEditAddressFormViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 31/3/24.
//

import Foundation
import Combine
import SwiftUI

final class ProfileEditAddressFormViewModel: ObservableObject {
    
    @Published var street: Binding<String>
    @Published var number: Binding<Int>
    @Published var postcode: Binding<Int>
    @Published var city: Binding<String>
    @Published var state: Binding<String>
    @Published var country: Binding<String>
    
    init(
        street: Binding<String>,
        number: Binding<Int>,
        postcode: Binding<Int>,
        city: Binding<String>,
        state: Binding<String>,
        country: Binding<String>
    ) {
        self.street = street
        self.number = number
        self.postcode = postcode
        self.city = city
        self.state = state
        self.country = country
    }
}
