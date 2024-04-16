//
//  ProfileView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import SwiftUI

struct ProfileView<Presenter:ProfilePresenter>: View {
    
    @StateObject var presenter: Presenter
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
        .sheet(isPresented: $presenter.isEditAddressVisible) {
            ProfileEditAddressForm(viewModel: ProfileEditAddressFormViewModel(
                street: $presenter.user.location.street,
                number: $presenter.user.location.number,
                postcode: $presenter.user.location.postcode,
                city: $presenter.user.location.city,
                state: $presenter.user.location.state,
                country: $presenter.user.location.country
            ))
        }
        .alert(
            isPresented: $presenter.alertIsVisible,
            viewModel: $presenter.alertViewModel
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
            url: presenter.user.avatar
        ))
    }

    private var addressInfo: some View {
        VStack(spacing: Theme.Spacing.xSmall) {
            Text("\(presenter.user.username.title) \(presenter.user.username.first) \(presenter.user.username.last)")
                .font(Theme.Font.titleBold)
            Text(presenter.user.email)
                .font(Theme.Font.bodyBold)
            Text(presenter.user.phone)
                .font(Theme.Font.bodyBold)
            Text("\(presenter.user.location.street), \(presenter.user.location.number) (\(presenter.user.location.city))")
                .font(Theme.Font.bodyBold)
            Text("\(presenter.user.location.state) - \(presenter.user.location.country)")
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
                presenter.routeToMap()
            }, label: {
                Image(systemName: Assets.SystemImage.mappinAndEllipse)
            })
            .buttonStyle(.borderedProminent)
            .shadow(color: .black, radius: Theme.Radius.medium)
            Button(action: {
                presenter.searchLocationAndRouteToMap()
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
            presenter.isEditAddressVisible = true
        }
        .buttonStyle(.borderedProminent)
        .shadow(color: .black, radius: Theme.Radius.medium)
    }
    
    private var newProfileDataButton: some View {
        Button(Strings.ProfileScreen.getNewUserButtonTitle) {
            presenter.restoreUserWithRandom()
        }
        .buttonStyle(.borderedProminent)
        .shadow(color: .black, radius: Theme.Radius.medium)
        .padding(.top, Theme.Spacing.xxLarge)
    }
}

#Preview {
    ProfileView<MockProfilePresenter>(presenter: MockProfilePresenter())
        .environmentObject(MockProfilePresenter())
}
