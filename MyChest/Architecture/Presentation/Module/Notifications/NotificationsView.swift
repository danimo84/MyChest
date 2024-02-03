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
                                VStack {
                                    Text(notification.title)
                                    Text(notification.body)
                                    Text(notification.isReaded ? "Readed" : "Unreaded")
                                    Text(notification.isSent ? "Sent" : "Scheduled")
                                }
                                .onTapGesture {
                                    viewModel.onNotificationTapppedWithId(notification.id)
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
