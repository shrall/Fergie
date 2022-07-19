//
//  TaskViewModel.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import CoreData
import Foundation
import UserNotifications

class TaskViewModel: ObservableObject {
    @Published var date = Date()
    //@Published var isRepeated = false
    //@Published var notificationFrequency = 0
    //@Published var notificationType = "hour"
    //@Published var repeatFrequency = 0
    @Published var title = ""
    @Published var isDone = false
    
    @Published var tasks: [Task] = []
    
    //Notifications Manager
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func createTask(context:NSManagedObjectContext){
        let task = Task(context: context)
        task.id = UUID()
        task.date = date
        task.isRepeated = false//isRepeated
        task.notificationFrequency = 0//Int16(notificationFrequency)
        task.notificationType = "hour"//notificationType
        task.repeatFrequency = 0//Int16(repeatFrequency)
        task.title = title
        task.createdAt = Date()
        task.isDone = false
        save(context: context)
        
        //Create Notif//
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: task.date ?? Date())
        guard let day = dateComponents.day,
              let month = dateComponents.month,
              let year = dateComponents.year,
              let hour = dateComponents.hour,
              let minute = dateComponents.minute
        else { return }
        
        createLocalNotification(title: "Hi Fergie",subTitle: "Dont Forget to \(task.title ?? "")", day: day, month: month, year: year, hour: hour, minute: minute, customId: "\(task.title ?? "")_\(dateToStringForCustomId(date: task.date ?? Date()))")
        //Create Notif//
    }
    
    
    func updateTask(context:NSManagedObjectContext, id:UUID){
        let task = getTask(context: context, id: id)!
        
        //Delete Notif//
        let dateToStringDelete = dateToStringForCustomId(date: task.date ?? Date())
        deleteLocalNotifications(identifiers: ["\(task.title ?? "")_\(dateToStringDelete)"])
        //Delete Notif//
        
        task.date = date
        task.isRepeated = false//isRepeated
        task.notificationFrequency = 0//Int16(notificationFrequency)
        task.notificationType = "hour"//notificationType
        task.repeatFrequency = 0//Int16(repeatFrequency)
        task.title = title
        task.updatedAt = Date()
        task.isDone = isDone
        save(context: context)
        
        //ReCreate Notif//
        let dateToStringReCreate = dateToStringForCustomId(date: task.date ?? Date())
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: task.date ?? Date())
        guard let day = dateComponents.day,
              let month = dateComponents.month,
              let year = dateComponents.year,
              let hour = dateComponents.hour,
              let minute = dateComponents.minute
        else { return }
        
        createLocalNotification(title: "Hi Fergie",subTitle: "Dont Forget to \(task.title ?? "")", day: day, month: month, year: year, hour: hour, minute: minute, customId: "\(task.title ?? "")_\(dateToStringReCreate)")
        //ReCreate Notif//
    }
    
    func checkedDone(context:NSManagedObjectContext, id:UUID){
        let task = getTask(context: context, id: id)!
        let dateToString = dateToStringForCustomId(date: task.date ?? Date())
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: task.date ?? Date())
        
        task.isDone.toggle()
        task.updatedAt = Date()
        if(task.isDone){
            deleteLocalNotifications(identifiers: ["\(task.title ?? "")_\(dateToString)"])
        }else{
            //Create Notif//
            guard let day = dateComponents.day,
                  let month = dateComponents.month,
                  let year = dateComponents.year,
                  let hour = dateComponents.hour,
                  let minute = dateComponents.minute
            else { return }
            
            createLocalNotification(title: "Hi Fergie",subTitle: "Dont Forget to \(task.title ?? "")", day: day, month: month, year: year, hour: hour, minute: minute, customId: "\(task.title ?? "")_\(dateToString)")
            //Create Notif//
        }
        save(context: context)
    }
    
    func finishTask(context:NSManagedObjectContext, id:UUID){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers:[id.uuidString])
        let task = getTask(context: context, id: id)!
        task.updatedAt = Date()
        task.isDone = !task.isDone
        save(context: context)
    }
    
    func timeToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        return dateFormatter.string(from: date)
    }
    
    func dateToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        
        return dateFormatter.string(from: date)
    }
    
    func dateToStringForCustomId(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyhhmm"
        
        return dateFormatter.string(from: date)
    }
    
    func deleteTask(context:NSManagedObjectContext, id:UUID){
        let task = getTask(context: context, id: id)!
        let dateToString = dateToStringForCustomId(date: task.date ?? Date())
        
        deleteLocalNotifications(identifiers: ["\(task.title ?? "")_\(dateToString)"])
        
        context.delete(
            getTask(context: context, id: id)!
        )
        save(context: context)
    }
    
    func save(context:NSManagedObjectContext){
        do{
            try context.save()
            resetVariables()
        }catch{
            
        }
    }
    
    func resetVariables(){
        date = Date()
        //isRepeated = false
        //notificationFrequency = 0
        //notificationType = "hour"
        //repeatFrequency = 0
        title = ""
        isDone = false
    }
    
    func getTask(context:NSManagedObjectContext, id: UUID?) -> Task? {
        guard let id = id else { return nil }
        let request = Task.fetchRequest() as NSFetchRequest<Task>
        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        guard let tasks = try? context.fetch(request) else { return nil }
        return tasks.first
    }
    
    func getAllTasks(context:NSManagedObjectContext, sort: String){
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sort, ascending: false)]
        do {
            let allTasks = try context.fetch(fetchRequest)
            tasks = allTasks
        } catch {
            fatalError("Uh, fetch problem...")
        }
    }
    
    
    //NOTIFICATION MANAGER//
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
    
    func createLocalNotification(title: String, subTitle: String, day: Int, month: Int, year: Int, hour: Int, minute: Int, customId: String) {
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
        
        //let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        let request = UNNotificationRequest(identifier: customId, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func deleteLocalNotifications(identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    func removeRequest(withIdentifier identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        if let index = notifications.firstIndex(where: {$0.identifier == identifier}) {
            notifications.remove(at: index)
            print("Pending: \(notifications.count)")
        }
    }
    
    
}
