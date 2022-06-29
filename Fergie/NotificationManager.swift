//
//  NotificationManager.swift
//  Fergie
//
//  Created by Candra Winardi on 27/06/22.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    //@Published private(set) var notificationID: String
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    func reloadLocalNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func createLocalNotification(title: String, subTitle: String, day: Int, month: Int, year: Int, hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = subTitle
        notificationContent.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func deleteLocalNotifications(identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
//    func getIDLocalNotifications(){
//        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
//            DispatchQueue.main.async {
//                self.notificationID = notifications
//            }
//        }
//    }
    
    func removeRequest(withIdentifier identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        if let index = notifications.firstIndex(where: {$0.identifier == identifier}) {
            notifications.remove(at: index)
            print("Pending: \(notifications.count)")
        }
    }
}
