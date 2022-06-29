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
    
    @State private var showRepeatModal = false
    
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
                    TextField("Title", text: $newTitle)
                        .font(Font.title3.weight(.bold))
                        .onAppear{
                            self.newTitle = self.taskListItem.title ?? ""
                        }.foregroundColor(.gray)
                } else{
                    TextField("Title", text: $newTitle)
                        .font(Font.title3.weight(.bold))
                        .onAppear{
                            self.newTitle = self.taskListItem.title ?? ""
                        }
                }
                if(taskListItem.isDone){
                    Text("\(taskListItem.date ?? Date(), style: .time)").foregroundColor(.gray)
                }else{
                    DatePicker("", selection: $newDate, displayedComponents: .hourAndMinute).labelsHidden()
                        .onAppear{
                            self.newDate = self.taskListItem.date ?? Date()
                        }
                }
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            
            if(!taskListItem.isDone){
                Button{
                    taskVM.title = newTitle
                    taskVM.date = newDate
                    taskVM.isDone = taskListItem.isDone
                    taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                }label: {
                    Text("Save").foregroundColor(.gray)
                }.buttonStyle(PlainButtonStyle()).padding(.trailing)
            }
        }
        .sheet(isPresented: $showRepeatModal) {
            RepeatTodayTaskView(showModal: $showRepeatModal, title: $newTitle, date: $newDate)
        }
        .swipeActions(edge: .trailing){
            Button {
                taskVM.deleteTask(context: viewContext, id: taskListItem.id!)
            } label: {
                Label("Delete", systemImage: "")
            }.tint(Color("TertiaryColor"))
            
            if(!taskListItem.isDone){
                Button {
                    showRepeatModal.toggle()
                } label: {
                    Label("Repeat", systemImage: "repeat")
                }.tint(Color("AccentColor"))
            }
        }
    }
}
