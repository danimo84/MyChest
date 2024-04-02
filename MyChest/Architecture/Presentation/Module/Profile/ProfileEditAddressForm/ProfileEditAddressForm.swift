//
//  ProfileEditAddressForm.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import SwiftUI

struct ProfileEditAddressForm<ViewModel: ProfileEditAddressFormViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        streetField
                        HStack {
                            numberField
                            postcodeField
                        }
                        stateField
                        cityField
                        countryField
                    }
                }
                .navigationTitle(Strings.ProfileScreen.editAddressTitle)
            }
        }
        .presentationDetents([.medium])
    }
    
    private var streetField: some View {
        TextFieldHeadered(
            text: viewModel.street,
            placeholder: Strings.ProfileScreen.streetPlacehoder
        )
    }
    
    private var numberField: some View {
        TextFieldValueHeadered(
            value: viewModel.number,
            placeholder: Strings.ProfileScreen.numberPlacehoder
        )
    }
    
    private var postcodeField: some View {
        TextFieldValueHeadered(
            value: viewModel.postcode,
            placeholder: Strings.ProfileScreen.postcodePlacehoder
        )
    }
    
    private var stateField: some View {
        TextFieldHeadered(
            text: viewModel.state,
            placeholder: Strings.ProfileScreen.statePlacehoder
        )
    }
    
    private var cityField: some View {
        TextFieldHeadered(
            text: viewModel.city,
            placeholder: Strings.ProfileScreen.cityPlacehoder
        )
    }
    
    private var countryField: some View {
        TextFieldHeadered(
            text: viewModel.country,
            placeholder: Strings.ProfileScreen.countryPlacehoder
        )
    }
}

#Preview {
    @State var street: String = "Castellana"
    @State var number: Int = 30
    @State var postcode: Int = 28022
    @State var city: String = "Madrid"
    @State var state: String = "Madrid"
    @State var country: String = "Spain"
    
    return ProfileEditAddressForm(
        viewModel: ProfileEditAddressFormViewModel(
            street: $street,
            number: $number,
            postcode: $postcode,
            city: $city,
            state: $state,
            country: $country
        )
    )
}
