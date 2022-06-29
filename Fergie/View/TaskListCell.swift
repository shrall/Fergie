//
//  TaskListCell.swift
//  Fergie
//
//  Created by Candra Winardi on 22/06/22.
//

import SwiftUI

struct TaskListCell: View{
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var taskVM:TaskViewModel
    @ObservedObject var taskListItem:Task //CoreData
    
    @State private var newTitle = ""
    @State private var newDate = Date()
    
    //Repeat Modal Button
    @State private var checkedRepeatButton: String = "None"
    @State private var presentedRepeatButton: Bool = false
    
    var body: some View{
        DisclosureGroup {
            if(!taskListItem.isDone){
                DatePicker("", selection: $newDate, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
                
                //Form Picker
                Button {
                    presentedRepeatButton.toggle()
                } label: {
                    HStack{
                        Text("Repeat")
                        Spacer()
                        Text(self.checkedRepeatButton).foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                    }
                }.fullScreenCover(isPresented: $presentedRepeatButton) {
                    RepeatModalView(isPresentRepeatModal: $presentedRepeatButton, isCheckedRepeatModal: $checkedRepeatButton)
                }

            }
        } label: {
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
                        TextField("Title", text: $newTitle)
                            .font(.system(size: 16))
                            .onAppear{
                                self.newTitle = self.taskListItem.title ?? ""
                            }
                    }
                    if(taskListItem.isDone){
                        Text("\(taskListItem.date ?? Date(), style: .time)").foregroundColor(.gray)
                    }else{
                        Text(taskVM.dateToString(date: newDate))
                            .onAppear{
                                self.newDate = self.taskListItem.date ?? Date()
                            }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                
                if(!taskListItem.isDone){
                    Button{
                        if(checkedRepeatButton == "None"){
                            taskVM.title = newTitle
                            taskVM.date = newDate
                            taskVM.isDone = taskListItem.isDone
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                        }else if(checkedRepeatButton == "Tomorrow"){
                            taskVM.title = newTitle
                            taskVM.date = newDate
                            taskVM.isDone = taskListItem.isDone
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                            
                            taskVM.title = newTitle
                            taskVM.date = newDate.addingTimeInterval(1.0 * 24.0 * 3600.0)
                            taskVM.createTask(context: viewContext)
                        }else if(checkedRepeatButton == "in 7 Days"){
                            taskVM.title = newTitle
                            taskVM.date = newDate
                            taskVM.isDone = taskListItem.isDone
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                            
                            for i in 1...7{
                                taskVM.title = newTitle
                                taskVM.date = newDate.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                                taskVM.createTask(context: viewContext)
                            }
                        }
                    }label: {
                        Text("Save").foregroundColor(.gray)
                    }.buttonStyle(PlainButtonStyle())
                }else{
                    Text("+10 Coins").font(.system(size: 13)).foregroundColor(.gray).padding(.top)
                }
            }
        }.accentColor(.clear)
            .swipeActions(edge: .trailing){
                Button {
                    taskVM.deleteTask(context: viewContext, id: taskListItem.id!)
                } label: {
                    Text("Delete")
                }.tint(Color("TertiaryColor"))
            }
    }
}
