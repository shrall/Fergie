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
    @ObservedObject var userSettings = UserSettings()
    
    @Binding var limitTask: Int
    
    @State private var setTimeType = ""
    @State private var editTaskModalPresented = false
    
    
    var body: some View{
        HStack{
            Button{
                taskVM.checkedDone(context: viewContext, id: taskListItem.id!)
                if(taskListItem.isDone){
                    if limitTask > 0{
                        userSettings.coin += 10
                        if userSettings.mood <= 10{
                            userSettings.mood += 1
                        }
                    }
                    limitTask -= 1
                }else{
                    limitTask += 1
                    if limitTask > 0{
                        userSettings.coin -= 10
                        if userSettings.mood <= 10{
                            userSettings.mood -= 1
                        }
                    }
                }
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
            } label: {
                Text("Delete")
            }.tint(Color("TertiaryColor"))
        }
    }
}
