//
//  TodayTaskListView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 24/06/22.
//

import SwiftUI
import UserNotifications

struct TodayTaskListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    @State var clickedTaskID = [UUID()]
    
    var body: some View {
        VStack(alignment:.leading){
            if(taskViewModel.tasks.count > 0){
                List{
                    ForEach(taskViewModel.tasks, id:\.self){ task in
                        if(!task.isDone){
                            HStack{
                                Button{
                                    if(!clickedTaskID.contains(task.id!)){
                                        clickedTaskID.append(task.id!)
                                        delayFinishTask(taskID: task.id!)
                                    }else{
                                        clickedTaskID.remove(at: clickedTaskID.firstIndex(of: task.id!)!)
                                    }
                                }label:{
                                    !clickedTaskID.contains(task.id!) ?
                                    Image(systemName: "circle").foregroundColor(Color.primary) : Image(systemName: "circle.inset.filled").foregroundColor(Color.accentColor)
                                }
                                !clickedTaskID.contains(task.id!) ? Text(task.title!).foregroundColor(Color.primary) : Text(task.title!).foregroundColor(Color.secondary)
                            }
                            .listItemTint(
                                !clickedTaskID.contains(task.id!) ? Color("ListBackgroundColor")
                                : Color("AccentColorDim"))
                        }
                    }
                }
            }else{
                VStack{
                    Image("fergieEmptyPlaceholder").resizable().frame(width: 120, height: 100)
                    Text("No tasks left for today.")
                }
            }
        }
        .onAppear{
//            taskViewModel.title = "nyoba aja \(Int.random(in: 1..<522))"
//            taskViewModel.date = Date().adding(.minute, value: 1)
//            taskViewModel.createTask(context: viewContext)
//            taskViewModel.getAllTasks(context: viewContext, sort: "date")
            
            for task in taskViewModel.tasks {
                if(!task.isDone){
                    let content = UNMutableNotificationContent()
                    content.title = task.title!
                    content.subtitle = "Due by \(task.date!.dateFormatting())"
                    content.sound = UNNotificationSound.default
                    content.categoryIdentifier = "FergieTest"
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request) { (error) in
                        if let error = error {
                            debugPrint(error)
                        }
                    }
                }
            }
        }
    }
    
    private func delayFinishTask(taskID: UUID) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if(clickedTaskID.contains(taskID)){
                taskViewModel.finishTask(context: viewContext, id: taskID)
                taskViewModel.getAllTasks(context: viewContext, sort: "date")
            }
        }
    }
}

struct TodayTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTaskListView()
    }
}
