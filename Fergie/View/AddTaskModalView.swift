//
//  SetTimeEmptyModalView.swift
//  Fergie
//
//  Created by Candra Winardi on 12/07/22.
//

import SwiftUI

struct AddTaskModalView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var dismissModal
    
    @EnvironmentObject var taskVM:TaskViewModel
    
    @Binding var setTimeType: String
    
    @State var title = ""
    @State var setDateTime = Date()
    @State var setRepeat = ""
    @State var isSetRepeatDisclosureGroupExpanded = false
    
    var body: some View {
        NavigationView{
            List{
                TextField("Title", text: $title).padding(.vertical, 10)
                
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
                    }.disabled(setTimeType == "Today" ? true : false)
                    
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
            }.navigationBarTitle("Add New Task").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button(action: {
                        self.dismissModal.wrappedValue.dismiss()
                    }, label: { Text("Cancel") }),

                    trailing: Button(action: {
                        if setRepeat == "Tomorrow"{
                            taskVM.title = title
                            taskVM.date = setDateTime
                            taskVM.createTask(context: viewContext)
                            
                            taskVM.title = title
                            taskVM.date = setDateTime.addingTimeInterval(1.0 * 24.0 * 3600.0)
                            taskVM.createTask(context: viewContext)
                        }
                        else if setRepeat == "This Week"{
                            for i in 0...7{
                                taskVM.title = title
                                taskVM.date = setDateTime.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                                taskVM.createTask(context: viewContext)
                            }
                        }
                        else if setRepeat == "This Month"{
                            for i in 0...30{
                                taskVM.title = title
                                taskVM.date = setDateTime.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                                taskVM.createTask(context: viewContext)
                            }
                        }
                        else{
                            taskVM.title = title
                            taskVM.date = setDateTime
                            taskVM.createTask(context: viewContext)
                        }
                        
                        self.dismissModal.wrappedValue.dismiss()
                    }, label: { Text("Done") })
                )
        }
    }
}
