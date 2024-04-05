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
                        ForEach(viewModel.notifications) {
                            if $0.isSent {
                                notificationCard($0)
                            }
                        }
                    }
                } else {
                    Text(Strings.NotificationsScreen.emptyState)
                }
            }
            .navigationTitle(Strings.NotificationsScreen.title)
            .onAppear {
                viewModel.getNotifications()
            }
        }
    }
    
    private func notificationCard(_ notification: LocalNotification) -> some View {
        VStack(spacing: Theme.Spacing.small) {
            notificationTitle(notification.title)
            notificationBody(notification.body)
            notificationDatetime(notification.datetime.description)
        }
        .listRowBackground(notification.isReaded ? .clear : Color.blue)
        .onTapGesture {
            viewModel.markNotifAsReadedAndNavigate(notification.id, accountId: notification.accountId)
        }
    }
    
    private func notificationTitle(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(Theme.Font.bodyBold)
            Spacer()
        }
    }
    
    private func notificationBody(_ body: String) -> some View {
        HStack {
            Text(body)
                .font(Theme.Font.body)
            Spacer()
        }
    }
    
    private func notificationDatetime(_ datetime: String) -> some View {
        HStack {
            Spacer()
            Text(datetime)
                .font(Theme.Font.caption)
        }
    }
}

#Preview {
    NotificationsView<MockNotificationsViewModel>(viewModel: MockNotificationsViewModel())
        .environmentObject(MockNotificationsViewModel())
}
