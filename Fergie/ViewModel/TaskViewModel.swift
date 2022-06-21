//
//  TaskViewModel.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import CoreData
import Foundation

class TaskViewModel: ObservableObject {
    @Published var date = Date()
    @Published var isRepeated = false
    @Published var notificationFrequency = 0
    @Published var notificationType = "hour"
    @Published var repeatFrequency = 0
    @Published var title = ""
    @Published var isDone = false
    
    @Published var tasks: [Task] = []
    
    func createTask(context:NSManagedObjectContext){
        let task = Task(context: context)
        task.id = UUID()
        task.date = date
        task.isRepeated = isRepeated
        task.notificationFrequency = Int16(notificationFrequency)
        task.notificationType = notificationType
        task.repeatFrequency = Int16(repeatFrequency)
        task.title = title
        task.createdAt = Date()
        task.isDone = false
        save(context: context)
    }
    
    func updateTask(context:NSManagedObjectContext, id:UUID){
        let task = getTask(context: context, id: id)!
        task.date = date
        task.isRepeated = isRepeated
        task.notificationFrequency = Int16(notificationFrequency)
        task.notificationType = notificationType
        task.repeatFrequency = Int16(repeatFrequency)
        task.title = title
        task.updatedAt = Date()
        task.isDone = isDone
        save(context: context)
    }
    
    func deleteTask(context:NSManagedObjectContext, id:UUID){
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
        isRepeated = false
        notificationFrequency = 0
        notificationType = "hour"
        repeatFrequency = 0
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
}
