//
//  FergieApp.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import SwiftUI

@main
struct FergieApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var taskViewModel = TaskViewModel()

    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(taskViewModel)
        }
    }
}
