//
//  FergieApp.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import SwiftUI

@main
struct FergieApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
