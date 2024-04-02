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
            userRepository.updateUser(user)
            setupFormattedAddress()
        }
    }
    @Published var isEditAddressVisible: Bool = false
    @Published var alertIsVisible: Bool = false
    @Published var alertViewModel: AlertViewModel = .empty()
    
    private var address: String = ""
    private var subscriptions = Set<AnyCancellable>()
    
    private let userRepository: UserRepository
    private let geocoderRepository: GeocoderRepository
    private let router: Router = Router.shared
    
    init(
        userRepository: UserRepository,
        geocoderRepository: GeocoderRepository
    ) {
        self.userRepository = userRepository
        self.geocoderRepository = geocoderRepository
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
        print("Address to search -> \(address)")
        fetchCoordinates(forAdress: user.location.street)
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
        userRepository.removeAll()
    }
    
    func fetchUser() {
        userRepository.getUser()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error: \(error)")
                        self.configureAlertError(message: error.localizedDescription)
                    }
                },
                receiveValue: {
                    self.user = $0
                    print("User: \($0)")
                }
            )
            .store(in: &subscriptions)
    }
    
    func fetchCoordinates(forAdress adress: String) {
        geocoderRepository.getCoordinates(forAdress: adress)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error: \(error)")
                        self.configureAlertError(message: error.localizedDescription)
                    }
                },
                receiveValue: {
                    print("Coordinates: Lat -> \($0.latitude) Long -> \($0.longitude)")
                    if !$0.latitude.isEmpty, !$0.longitude.isEmpty {
                        self.user.location.latitude = $0.latitude
                        self.user.location.longitude = $0.longitude
                        self.navigateToMap()
                    } else {
                        self.configureGenericAlertError()
                    }
                }
            )
            .store(in: &subscriptions)
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
