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
            if(taskViewModel.tasks.filter({$0.isDone == false}).count > 0){
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
                    Text("No tasks left for today.").font(Font.system(size: 14)).multilineTextAlignment(.center)
                }
            }
        }.onAppear{
            taskViewModel.getTodayTasks(context: viewContext)
        }
    }
    
    private func delayFinishTask(taskID: UUID) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if(clickedTaskID.contains(taskID)){
                taskViewModel.finishTask(context: viewContext, id: taskID)
            }
        }
    }
}

struct TodayTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTaskListView()
    }
}
