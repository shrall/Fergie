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
    @State var isLinkActive = false

    var body: some Scene {
        WindowGroup {
            if isLinkActive {
                TaskView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(taskViewModel)
            } else {
                OnboardingView(isLinkActive: $isLinkActive)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(taskViewModel)
            }
        }
    }
}
