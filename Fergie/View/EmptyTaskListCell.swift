//
//  EmptyTaskListCell.swift
//  Fergie
//
//  Created by Candra Winardi on 23/06/22.
//

import SwiftUI

struct EmptyTaskListCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var taskVM:TaskViewModel
    
    @State private var title = ""
    @State private var date = Date()
    
    @State private var setTimeType = ""
    
    //Repeat Modal Button
    @State private var checkedRepeatButton: String = "None"
    @State private var showDateModal: Bool = false
    
    @State private var isDisabled = false
    
    var body: some View {
        /*DisclosureGroup{
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
                //RepeatModalView(isPresentRepeatModal: $presentedRepeatButton, isCheckedRepeatModal: $checkedRepeatButton)
            }
        }label: {
            
        }.accentColor(.clear)*/
        
        HStack{
            Image(systemName: "plus").padding(.leading)
            
            ZStack{
                Button{
                    isDisabled.toggle()
                }label: {
                    Text("Type Here").foregroundColor(isDisabled ? .clear : .gray)
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                    .disabled(isDisabled)
                
                if isDisabled{
                    VStack(alignment: .leading, spacing: 5){
                        TextField("Title", text: $title)
                            .font(.system(size: 16))
                        
                        Button{
                            showDateModal.toggle()
                            self.setTimeType = "EmptyToday"
                        }label: {
                            Text("Set Time")
                                .padding(.horizontal, 15)
                                    .padding(.vertical, 5)
                                    .background(Color("AccentColor"))
                                    .foregroundColor(colorScheme == .light ? .white : .black)
                                    .clipShape(Capsule())
                        }.sheet(isPresented: $showDateModal, content: {
                            //SetTimeEmptyModalView(setTimeType: $setTimeType)
                        })
                        
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                }
            }
            
            Spacer()
            
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
                
                //For reset value
                title = ""
                date = Date()
                showDateModal = false
            }label: {
                Text("Save").foregroundColor(isDisabled ? Color("AccentColor") : .clear)
            }.buttonStyle(.plain)
        }
    }
}
