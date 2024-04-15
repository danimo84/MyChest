//
//  ProfileView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import SwiftUI

struct ProfileView<ViewModel:ProfilePresenter>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Spacer()
            remoteImage
            addressInfo
            locationButtons
            editLocationButton
            Spacer()
            newProfileDataButton
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(Strings.ProfileScreen.profileTitle)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.isEditAddressVisible) {
            ProfileEditAddressForm(viewModel: ProfileEditAddressFormViewModel(
                street: $viewModel.user.location.street,
                number: $viewModel.user.location.number,
                postcode: $viewModel.user.location.postcode,
                city: $viewModel.user.location.city,
                state: $viewModel.user.location.state,
                country: $viewModel.user.location.country
            ))
        }
        .alert(
            isPresented: $viewModel.alertIsVisible,
            viewModel: $viewModel.alertViewModel
        )
    }
    
    private var remoteImage: some View {
        RemoteImage(viewModel: RemoteImageViewModel(
            width: Theme.Profile.avatarSize,
            height: Theme.Profile.avatarSize,
            clipedShape: true,
            overlied: true,
            strokeWidth: Theme.Profile.avatarStrokeWidth,
            strokeColor: .black,
            shadowed: true,
            shadowRadius: Theme.Profile.avatarShadowRadius,
            shadowColor: .black,
            url: viewModel.user.avatar
        ))
    }

    private var addressInfo: some View {
        VStack(spacing: Theme.Spacing.xSmall) {
            Text("\(viewModel.user.username.title) \(viewModel.user.username.first) \(viewModel.user.username.last)")
                .font(Theme.Font.titleBold)
            Text(viewModel.user.email)
                .font(Theme.Font.bodyBold)
            Text(viewModel.user.phone)
                .font(Theme.Font.bodyBold)
            Text("\(viewModel.user.location.street), \(viewModel.user.location.number) (\(viewModel.user.location.city))")
                .font(Theme.Font.bodyBold)
            Text("\(viewModel.user.location.state) - \(viewModel.user.location.country)")
                .font(Theme.Font.headlineBold)
        }
        .padding(Theme.Spacing.large)
        .shadow(color: .black, radius: Theme.Radius.medium)
        .padding(.top, Theme.Spacing.xxLarge)
        .multilineTextAlignment(.center)
    }
    
    private var locationButtons: some View {
        HStack {
            Button(action: {
                viewModel.routeToMap()
            }, label: {
                Image(systemName: Assets.SystemImage.mappinAndEllipse)
            })
            .buttonStyle(.borderedProminent)
            .shadow(color: .black, radius: Theme.Radius.medium)
            Button(action: {
                viewModel.searchLocationAndRouteToMap()
            }, label: {
                Image(systemName: Assets.SystemImage.magnifyingglass)
                Image(systemName: Assets.SystemImage.mappinAndEllipse)
            })
            .buttonStyle(.borderedProminent)
            .shadow(color: .black, radius: Theme.Radius.medium)
        }
    }
    
    private var editLocationButton: some View {
        Button(Strings.ProfileScreen.editAddressButtonTitle) {
            viewModel.isEditAddressVisible = true
        }
        .buttonStyle(.borderedProminent)
        .shadow(color: .black, radius: Theme.Radius.medium)
    }
    
    private var newProfileDataButton: some View {
        Button(Strings.ProfileScreen.getNewUserButtonTitle) {
            viewModel.restoreUserWithRandom()
        }
        .buttonStyle(.borderedProminent)
        .shadow(color: .black, radius: Theme.Radius.medium)
        .padding(.top, Theme.Spacing.xxLarge)
    }
}

#Preview {
    ProfileView<MockProfilePresenter>()
        .environmentObject(MockProfilePresenter())
}
