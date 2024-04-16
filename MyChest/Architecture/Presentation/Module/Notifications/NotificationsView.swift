//
//  NotificationsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import SwiftUI

struct NotificationsView<Presenter: NotificationsPresenter>: View {
    
    @StateObject var presenter: Presenter
    
    var body: some View {
        NavigationStack {
            VStack {
                if !presenter.notifications.isEmpty {
                    List {
                        ForEach(presenter.notifications) {
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
                presenter.getNotifications()
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
            presenter.markNotifAsReadedAndNavigate(notification.id, accountId: notification.accountId)
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
    NotificationsView<MockNotificationsPresenter>(presenter: MockNotificationsPresenter())
        .environmentObject(MockNotificationsPresenter())
}
