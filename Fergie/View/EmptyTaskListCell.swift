//
//  EmptyTaskListCell.swift
//  Fergie
//
//  Created by Candra Winardi on 23/06/22.
//

import SwiftUI

struct EmptyTaskListCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var taskVM:TaskViewModel
    @StateObject private var notificationManager = NotificationManager()
    
    @State private var title = ""
    @State private var date = Date()
    
    @Binding var isPresented:Bool
    
    //Repeat Modal Button
    @State private var checkedRepeatButton: String = "None"
    @State private var presentedRepeatButton: Bool = false
    
    var body: some View {
        DisclosureGroup{
            DatePicker("", selection: $date, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
            
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
        }label: {
            HStack{
                Image(systemName: "plus").padding(.leading)
                
                VStack(alignment: .leading, spacing: 5){
                    TextField("Title", text: $title)
                        .font(.system(size: 16))
                    Text(taskVM.dateToString(date: date))
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                
                Button{
                    if(checkedRepeatButton == "None"){
                        taskVM.title = title
                        taskVM.date = date
                        taskVM.createTask(context: viewContext)
                    }else if(checkedRepeatButton == "Tomorrow"){
                        for i in 0...1{
                            taskVM.title = title
                            taskVM.date = date.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                            taskVM.createTask(context: viewContext)
                        }
                    }else if(checkedRepeatButton == "in 7 Days"){
                        for i in 0...7{
                            taskVM.title = title
                            taskVM.date = date.addingTimeInterval(Double(i) * 24.0 * 3600.0)
                            taskVM.createTask(context: viewContext)
                        }
                    }
                    
                    //notification setting
                    let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
                    guard let day = dateComponents.day,
                          let month = dateComponents.month,
                          let year = dateComponents.year,
                          let hour = dateComponents.hour,
                          let minute = dateComponents.minute
                    else { return }
                    notificationManager.createLocalNotification(title: "Hi Fergie",subTitle: "Dont Forget to \(title)", day: day, month: month, year: year, hour: hour, minute: minute) { error in
                        if error == nil {
                            DispatchQueue.main.async {
                                self.isPresented = false
                            }
                        }
                    }
                    
                    //For reset value
                    title = ""
                    date = Date()
                }label: {
                    Text("Save").foregroundColor(.gray)
                }
            }
        }.accentColor(.clear)
    }
}
