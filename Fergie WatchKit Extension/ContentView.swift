//
//  ContentView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationView{
                TodayTaskListView().navigationBarTitleDisplayMode(.inline).navigationTitle(Text("Today"))
            }
            .tag(1)
            NavigationView{
                FergieMoodView().navigationBarTitleDisplayMode(.inline).navigationTitle("Fergie")
            }
            .tag(2)
        }.onAppear{
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { success, error in
                if success {
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
