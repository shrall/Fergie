//
//  TaskView.swift
//  Fergie
//
//  Created by Candra Winardi on 21/06/22.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var taskVM:TaskViewModel
    @StateObject private var notificationManager = NotificationManager()
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: true)]) var fetchedTaskList:FetchedResults<Task>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "date > %@", Date().endOfDay as CVarArg)) var upcomingTaskListCount:FetchedResults<Task>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "date >= %@ && date <= %@", Date().startOfDay as CVarArg, Date().endOfDay as CVarArg)) var todayTaskListCount:FetchedResults<Task>
    
    @State private var todayOrUpcoming = 0
    @State private var isPresented = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.accentColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.accentColor)], for: .normal)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("", selection: $todayOrUpcoming) {
                    Text("Today").tag(0)
                    Text("Upcoming").tag(1)
                }.pickerStyle(.segmented).padding()
                if(todayOrUpcoming == 0){
                    if todayTaskListCount.count > 0{
                        List{
                            Section(header: Text("To Do List").font(Font.title2.weight(.bold)).foregroundColor(.black)){
                                ForEach(fetchedTaskList.filter{$0.isDone == false && $0.date ?? Date() >= Date().startOfDay && $0.date ?? Date() <= Date().endOfDay}){ item in
                                    TaskListCell(taskListItem: item)
                                }
                                
                                EmptyTaskListCell(isPresented: $isPresented)
                            }
                            
                            Section(header: Text("Done").font(Font.title2.weight(.bold)).foregroundColor(.black)){
                                ForEach(fetchedTaskList.filter{$0.isDone == true}){ item in
                                    TaskListCell(taskListItem: item)
                                }
                            }
                        }.listStyle(InsetListStyle())
                    } else{
                        ScrollView{
                            EmptyTaskListCell(isPresented: $isPresented)
                            VStack(alignment: .center) {
                                Image("FergieCoins").resizable()
                                    .scaledToFit().frame(maxWidth: UIScreen.main.bounds.width * 0.75).padding()
                                Text("You know what? You can earn")
                                Text("coins by completing task.")
                                Button { } label: {
                                    Text("Add New Task").foregroundColor(.white)
                                }.padding().padding(.leading, 50).padding(.trailing,50)
                                    .background(Color("AccentColor")).cornerRadius(30)

                            }.padding(.top, UIScreen.main.bounds.height * 0.05)
                        }
                    }
                    
                }else{
                    if upcomingTaskListCount.count > 0{
                        List{
                            ForEach((1...2), id: \.self){ item in
                                Section(header: item == 1 ? Text("Tomorrow").font(Font.title2.weight(.bold)).foregroundColor(.black) : Text("\(Date().startOfDay.addingTimeInterval(Double(item) * 24.0 * 3600.0), style: .date)").font(Font.title2.weight(.bold)).foregroundColor(.black)){
                                    ForEach(fetchedTaskList.filter{$0.date ?? Date() >= Date().startOfDay.addingTimeInterval(Double(item) * 24.0 * 3600.0) && $0.date ?? Date() <= Date().endOfDay.addingTimeInterval(Double(item) * 24.0 * 3600.0)}){ item in
                                        TaskListCell(taskListItem: item)
                                    }
                                }
                            }
                        }.listStyle(InsetListStyle())
                    } else{
                        ScrollView{
                            //EmptyTaskListCell()
                            VStack(alignment: .center) {
                                Image("FergieJump").resizable()
                                    .scaledToFit().frame(maxWidth: UIScreen.main.bounds.width * 0.75).padding()
                                Text("No upcoming schedule?")
                                Text("Try adding some more.")
                                Button { } label: {
                                    Text("Add New Task").foregroundColor(.white)
                                }.padding().padding(.leading, 50).padding(.trailing,50)
                                    .background(Color("AccentColor")).cornerRadius(30)

                            }.padding(.top, UIScreen.main.bounds.height * 0.05)
                        }
                    }
                }
            }.navigationTitle("Task")
                .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    notificationManager.reloadAuthorizationStatus()
                }
                .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
                    switch authorizationStatus {
                    case .notDetermined:
                        notificationManager.requestAuthorization()
                    case .authorized:
                        notificationManager.reloadLocalNotifications()
                    default:
                        break
                    }
                }
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        HStack{
                            Button{
                                //action to mascot view
                            }label: {
                                VStack{
                                    Image("FergieHappyButton").padding(.top, UIScreen.main.bounds.height * 0.08)
                                }
                            }
                        }
                    }
                }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView().environmentObject(TaskViewModel())
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

