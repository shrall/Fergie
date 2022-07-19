//
//  SetTimeModalView.swift
//  Fergie
//
//  Created by Candra Winardi on 28/06/22.
//

import SwiftUI

struct EditTaskModalView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var dismissModal
    
    @ObservedObject var taskListItem:Task //CoreData
    @EnvironmentObject var taskVM:TaskViewModel
    
    @Binding var setTimeType: String
    
    @State var title = ""
    @State var setDateTime = Date()
    @State var setRepeat = ""
    @State var isSetRepeatDisclosureGroupExpanded = false
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Title", text: $title).padding(.vertical, 10)
                    .onAppear{
                        self.title = taskListItem.title ?? "None"
                    }
                
                Section{
                    DisclosureGroup{
                        DatePicker("", selection: $setDateTime, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }label: {
                        HStack{
                            Group{
                                Image(systemName: "calendar").foregroundColor(Color("AccentColor"))
                                Text("Set Date")
                            }.font(Font.system(size: 18))
                            Spacer()
                            Text("\(taskVM.dateToString(date: setDateTime))").font(Font.system(size: 14)).foregroundColor(.gray)
                        }.padding(.vertical, 10)
                    }
                    
                    DisclosureGroup{
                        DatePicker("", selection: $setDateTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                    }label: {
                        HStack{
                            Group{
                                Image(systemName: "clock").foregroundColor(Color("AccentColor"))
                                Text("Set Time")
                            }.font(Font.system(size: 18))
                            Spacer()
                            Text("\(taskVM.timeToString(date: setDateTime))").font(Font.system(size: 14)).foregroundColor(.gray)
                                .onAppear{
                                    self.setDateTime = taskListItem.date ?? Date()
                                }
                        }.padding(.vertical, 10)
                    }
                }
                
                DisclosureGroup(isExpanded: $isSetRepeatDisclosureGroupExpanded){
                    Button{
                        setRepeat = "Tomorrow"
                        isSetRepeatDisclosureGroupExpanded.toggle()
                    }label: {
                        Text("Tomorrow").padding(.vertical, 10)
                    }
                    
                    Button{
                        setRepeat = "This Week"
                        isSetRepeatDisclosureGroupExpanded.toggle()
                    }label: {
                        Text("This Week").padding(.vertical, 10)
                    }
                    
                    Button{
                        setRepeat = "This Month"
                        isSetRepeatDisclosureGroupExpanded.toggle()
                    }label: {
                        Text("This Month").padding(.vertical, 10)
                    }
                }label: {
                    HStack{
                        Group{
                            Image(systemName: "repeat").foregroundColor(Color("AccentColor"))
                            Text("Repeat For")
                        }.font(Font.system(size: 18))
                        Spacer()
                        Text("\(setRepeat)").font(Font.system(size: 14)).foregroundColor(.gray)
                    }.padding(.vertical, 10)
                }
            }.navigationBarTitle("Edit Task").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button(action: {
                        self.dismissModal.wrappedValue.dismiss()
                    }, label: { Text("Cancel") }),

                    trailing: Button(action: {
                        if setRepeat == "Tomorrow"{
                            taskVM.title = title
                            taskVM.date = setDateTime
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                            
                            taskVM.title = title
                            taskVM.date = setDateTime.addingTimeInterval(1.0 * 24.0 * 3600.0)
                            taskVM.createTask(context: viewContext)
                        }else if setRepeat == "This Week"{
                            taskVM.title = title
                            taskVM.date = setDateTime
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                            
                            for i in 1...7{
                                taskVM.title = title
                                taskVM.date = setDateTime.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                                taskVM.createTask(context: viewContext)
                            }
                        }else if setRepeat == "This Month"{
                            taskVM.title = title
                            taskVM.date = setDateTime
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                            
                            for i in 1...30{
                                taskVM.title = title
                                taskVM.date = setDateTime.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                                taskVM.createTask(context: viewContext)
                            }
                        }else {
                            taskVM.title = title
                            taskVM.date = setDateTime
                            taskVM.updateTask(context: viewContext, id: taskListItem.id!)
                        }
                        
                        self.dismissModal.wrappedValue.dismiss()
                    }, label: { Text("Done") })
                )
        }
    }
}
