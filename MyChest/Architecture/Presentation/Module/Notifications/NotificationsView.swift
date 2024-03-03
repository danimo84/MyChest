//
//  NotificationsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import SwiftUI

struct NotificationsView<ViewModel: NotificationsViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.notifications.isEmpty {
                    List {
                        ForEach(viewModel.notifications) { notification in
                            if notification.isSent {
                                VStack(spacing: 12) {
                                    HStack {
                                        Text(notification.title)
                                            .font(Theme.Font.bodyBold)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(notification.body)
                                            .font(Theme.Font.body)
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        Text(notification.datetime.description)
                                            .font(Theme.Font.caption)
                                    }
                                }
                                .listRowBackground(notification.isReaded ? .clear : Color.blue)
                                .onTapGesture {
                                    viewModel.onNotificationTapppedWithId(notification.id, accountId: notification.accountId)
                                }
                            }
                        }
                    }
                } else {
                    Text("No hay notificaciones aún...")
                }
            }
            .navigationTitle("Notificaciones")
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}

#Preview {
    NotificationsView<MockNotificationsViewModel>(viewModel: MockNotificationsViewModel())
        .environmentObject(MockNotificationsViewModel())
}
