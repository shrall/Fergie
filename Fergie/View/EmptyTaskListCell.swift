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
    
    var body: some View {
        HStack{
            Image(systemName: "plus").padding(.leading)
            
            VStack(alignment: .leading, spacing: 5){
                TextField("Title", text: $title)
                    .font(Font.title3.weight(.bold))
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute).labelsHidden()
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            
            Button{
                taskVM.title = title
                taskVM.date = date
                taskVM.createTask(context: viewContext)
                
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
                Text("Save")
                    .foregroundColor(.gray)
            }.padding(.trailing)
        }
    }
}
