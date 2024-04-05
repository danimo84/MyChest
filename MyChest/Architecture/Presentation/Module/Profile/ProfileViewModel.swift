//
//  ProfileViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation
import Combine

protocol ProfileViewModel: ObservableObject, Alertable {
    var user: User { get set }
    var isEditAddressVisible: Bool { get set }
    
    func restoreUserWithRandom()
    func routeToMap()
    func searchLocationAndRouteToMap()
}

final class ProfileViewModelDefault {
    
    @Published var user: User = .mockUser() {
        didSet {
            updateUserInteractor.execute(user)
            setupFormattedAddress()
        }
    }
    @Published var isEditAddressVisible: Bool = false
    @Published var alertIsVisible: Bool = false
    @Published var alertViewModel: AlertViewModel = .empty()
    
    private var address: String = ""
    private var subscriptions = Set<AnyCancellable>()
    
    private let getUserInteractor: GetUserInteractor
    private let updateUserInteractor: UpdateUserInteractor
    private let deleteUserInteractor: DeleteUserInteractor
    private let getUserCoordinatesInteractor: GetUserCoordinatesInteractor
    private let router: Router = Router.shared
    
    init(
        getUserInteractor: GetUserInteractor,
        updateUserInteractor: UpdateUserInteractor,
        deleteUserInteractor: DeleteUserInteractor,
        getUserCoordinatesInteractor: GetUserCoordinatesInteractor
    ) {
        self.getUserInteractor = getUserInteractor
        self.updateUserInteractor = updateUserInteractor
        self.deleteUserInteractor = deleteUserInteractor
        self.getUserCoordinatesInteractor = getUserCoordinatesInteractor
        fetchUser()
    }
}

extension ProfileViewModelDefault: ProfileViewModel {
    
    func restoreUserWithRandom() {
        removeUser()
        fetchUser()
    }
    
    func routeToMap() {
        navigateToMap()
    }
    
    func searchLocationAndRouteToMap() {
        Task { await fetchCoordinates(forAdress: user.location.street) }
    }
}

private extension ProfileViewModelDefault {
    
    func setupFormattedAddress() {
        address = String(
            format: "%@ %d, %@ %@",
            user.location.street,
            user.location.number,
            user.location.city,
            user.location.state
        )
    }
    
    func removeUser() {
        deleteUserInteractor.execute()
    }
    
    func fetchUser() {
        getUserInteractor.execute()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.configureAlertError(message: error.localizedDescription)
                    }
                },
                receiveValue: {
                    self.user = $0
                }
            )
            .store(in: &subscriptions)
    }
    
    func fetchCoordinates(forAdress adress: String) async {
        getUserCoordinatesInteractor.execute(forAddress: adress)
            .sink(
                receiveCompletion: {
                    if case let .failure(error) = $0 {
                        self.configureAlertError(message: error.localizedDescription)
                    }
                },
                receiveValue: {
                    self.handleFetchCoordinatesResponseWithValue($0)
                }
            )
            .store(in: &subscriptions)
    }
    
    func handleFetchCoordinatesResponseWithValue(_ coordinates: UserCoordinates) {
        if !coordinates.latitude.isEmpty, !coordinates.longitude.isEmpty {
            user.location.latitude = coordinates.latitude
            user.location.longitude = coordinates.longitude
            navigateToMap()
        } else {
            configureGenericAlertError()
        }
    }
}

private extension ProfileViewModelDefault {
    
    func navigateToMap() {
        router.navigateTo(
            route: .map(
                latitude: user.location.latitude,
                longitude: user.location.longitude,
                address: address
            ),
            onPath: .settings
        )
    }
}

private extension ProfileViewModelDefault {
    
    func configureGenericAlertError() {
        alertViewModel = AlertViewModel(
            alertType: .genericError,
            dismissAction: {
                self.alertIsVisible = false
            })
        alertIsVisible = true
    }
    
    func configureAlertError(message: String) {
        alertViewModel = AlertViewModel(
            alertType: .customError(
                title: nil,
                message: message
            ),
            dismissAction: {
                self.alertIsVisible = false
            })
        alertIsVisible = true
    }
}
