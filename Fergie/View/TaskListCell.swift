//
//  TaskListCell.swift
//  Fergie
//
//  Created by Candra Winardi on 22/06/22.
//

import SwiftUI

struct TaskListCell: View{
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var taskVM:TaskViewModel
    @ObservedObject var taskListItem:Task //CoreData
    
    @State private var setTimeType = ""
    @State private var editTaskModalPresented = false
    
    var body: some View{
        HStack{
            Button{
                taskVM.checkedDone(context: viewContext, id: taskListItem.id!)
            }label: {
                if(taskListItem.isDone){
                    Image(systemName: "circle.inset.filled").foregroundColor(.gray).padding(.leading)
                }else{
                    Image(systemName: "circle").foregroundColor(Color("AccentColor")).padding(.leading)
                }
            }.buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 5){
                if(taskListItem.isDone){
                    Text("\(taskListItem.title ?? "None")").foregroundColor(.gray)
                } else{
                    Text("\(taskListItem.title ?? "None")")
                }
                
                if(taskListItem.isDone){
                    Text("\(taskListItem.date ?? Date(), style: .time)").foregroundColor(.gray)
                }else{
                    Text("\(taskListItem.date ?? Date(), style: .time)")
                }
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            
            Button{
                editTaskModalPresented.toggle()
                setTimeType = "Today"
            }label: {
                Text("")
            }.sheet(isPresented: $editTaskModalPresented){
                EditTaskModalView(taskListItem: taskListItem, setTimeType: $setTimeType)
            }
            
            if(taskListItem.isDone){
                Text("+10 Coins").font(.system(size: 13)).foregroundColor(.gray).padding(.top)
            }
        }.swipeActions(edge: .trailing){
            Button {
                taskVM.deleteTask(context: viewContext, id: taskListItem.id!)
                //notificationManager.deleteLocalNotifications(identifiers: [taskVM.title])
            } label: {
                Text("Delete")
            }.tint(Color("TertiaryColor"))
        }
    }
}
