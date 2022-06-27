//
//  FergieApp.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import SwiftUI

@main
struct FergieApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var taskViewModel = TaskViewModel()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(taskViewModel)
            }
        }
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "FergieTest")
        #endif
    }
}
