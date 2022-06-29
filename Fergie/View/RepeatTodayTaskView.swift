//
//  RepeatTodayTaskView.swift
//  Fergie
//
//  Created by Candra Winardi on 24/06/22.
//

import SwiftUI

struct RepeatTodayTaskView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var taskVM:TaskViewModel
    
    @Binding var showModal:Bool
    @Binding var title:String
    @Binding var date:Date
    
    @State var isRepeat:Int = 0
    
    var body: some View {
        NavigationView{
            VStack{
                Text(title).font(Font.title.weight(.bold))
                Text("\(date, style: .time)").font(Font.title.weight(.medium))
                
                DisclosureGroup("Due Date"){
                    DatePicker("Date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                }.padding()
                    
                DisclosureGroup("Repeat"){
                    Picker("Repeat", selection: $isRepeat){
                        Text("Not Selected").tag(0)
                        Text("Tomorrow").tag(1)
                        Text("in 7 Days").tag(7)
                    }.pickerStyle(.wheel)
                }.padding()
                
                Spacer()
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Apply") {
                        if (isRepeat == 0){
                            taskVM.title = title
                            taskVM.date = date
                            taskVM.createTask(context: viewContext)
                        }else if (isRepeat == 1){
                            taskVM.title = title
                            taskVM.date = date.addingTimeInterval(1.0 * 24.0 * 3600.0)
                            taskVM.createTask(context: viewContext)
                        }else if (isRepeat == 7){
                            for i in 1...7{
                                taskVM.title = title
                                taskVM.date = date.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                                taskVM.createTask(context: viewContext)
                            }
                        }
                        
                        showModal.toggle()
                    }
                }
            }
        }
    }
}
