//
//  TaskView.swift
//  Fergie
//
//  Created by Candra Winardi on 21/06/22.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var taskVM:TaskViewModel
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: true)]) var fetchedTaskList:FetchedResults<Task>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], predicate: NSPredicate(format: "date > %@", Date().endOfDay as CVarArg)) var upcomingTaskListCount:FetchedResults<Task>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return formatter
    }
    
    var dateFormatterForSorting: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        return formatter
    }
    
    func grouping(_ result : FetchedResults<Task>)-> [[Task]]{
        return Dictionary(grouping: result) { (element : Task)  in
            dateFormatterForSorting.string(from: element.date!)
        }.sorted(by: {$0.key < $1.key})
            .map {$0.value}
    }
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "date >= %@ && date <= %@", Date().startOfDay as CVarArg, Date().endOfDay as CVarArg)) var todayTaskListCount:FetchedResults<Task>
    
    @State private var todayOrUpcoming = 0
    @State private var isAddNewTaskModalPresented = false
    @State private var isShowAvatarActive = false
    @State private var setTimeType = ""
    @State private var limitTask = 10
    
    @State var checkTimeLimit = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var limitFormatter: DateFormatter {
        let fmtr = DateFormatter()
        fmtr.dateFormat = "hh:mm:ss a"
        return fmtr
    }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.accentColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.accentColor)], for: .normal)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: AvatarView(), isActive: $isShowAvatarActive) {
                    EmptyView()
                }
                
                HStack{
                    Text("Task").font(.largeTitle).bold()
                    Spacer()
                    Button{
                        isShowAvatarActive.toggle()
                    }label: {
                        Image("FergieHappyButton")
                        Image(systemName: "chevron.right")
                    }
                }.padding(.horizontal, 20).padding(.top, 30)
                
                Picker("", selection: $todayOrUpcoming) {
                    Text("Today").tag(0)
                    Text("Upcoming").tag(1)
                }.pickerStyle(.segmented).padding(.horizontal, 20)
                if(todayOrUpcoming == 0){
                    ZStack{
                        List{
                            Section(header: Text("To Do List").font(Font.system(size: 18).weight(.bold)).foregroundColor(colorScheme == .dark ? .white : .black)){
                                ForEach(fetchedTaskList.filter{$0.isDone == false && $0.date ?? Date() >= Date().startOfDay && $0.date ?? Date() <= Date().endOfDay}){ item in
                                    TaskListCell(taskListItem: item, limitTask: $limitTask)
                                }
                            }
                            
                            if todayTaskListCount.filter{$0.isDone == true}.count > 0{
                                Section(header: Text("Done").font(Font.system(size: 18).weight(.bold)).foregroundColor(colorScheme == .dark ? .white : .black)){
                                    ForEach(fetchedTaskList.filter{$0.isDone == true && $0.date ?? Date() >= Date().startOfDay && $0.date ?? Date() <= Date().endOfDay}){ item in
                                        TaskListCell(taskListItem: item, limitTask: $limitTask)
                                    }
                                }
                            }
                            
                            //ini buat munculin identifier nya notifications
                            /*ForEach(taskVM.notifications, id: \.identifier) { notification in
                             
                             Text(notification.identifier)
                             }*/
                            
                        }.listStyle(.inset)
                        
                        if todayTaskListCount.count == 0{
                            VStack{
                                Image("FergieCoins").resizable()
                                    .scaledToFit().frame(maxWidth: UIScreen.main.bounds.width * 0.75).padding()
                                Text("You know what? You can earn")
                                Text("coins by completing task.")
                                Button {
                                    isAddNewTaskModalPresented.toggle()
                                } label: {
                                    Text("Add New Task").foregroundColor(.white)
                                        .padding().padding(.leading, 50).padding(.trailing,50)
                                        .background(Color("AccentColor")).cornerRadius(30)
                                }.sheet(isPresented: $isAddNewTaskModalPresented) {
                                    AddTaskModalView(setTimeType: $setTimeType)
                                }
                                
                            }.padding(.top, UIScreen.main.bounds.height * 0.05)
                        }
                        Spacer()
                    }
                }else{
                    ZStack{
                        List{
                            ForEach(grouping(upcomingTaskListCount), id: \.self){ (section: [Task]) in
                                Section(header: Text("\(self.dateFormatter.string(from: section[0].date!) == self.dateFormatter.string(from: Date().addingTimeInterval(1.0 * 24.0 * 3600.0)) ? "Tomorrow" : self.dateFormatter.string(from: section[0].date!))").font(Font.system(size: 18).weight(.bold)).foregroundColor(colorScheme == .dark ? .white : .black)){
                                    ForEach(section){ itemDetails in
                                        TaskListCell(taskListItem: itemDetails, limitTask: $limitTask)
                                    }
                                }
                            }
                        }.listStyle(.inset)
                        if upcomingTaskListCount.count == 0{
                            VStack {
                                Image("FergieJump").resizable()
                                    .scaledToFit().frame(maxWidth: UIScreen.main.bounds.width * 0.75).padding()
                                Text("No upcoming schedule?")
                                Text("Try adding some more.")
                                Button {
                                    isAddNewTaskModalPresented.toggle()
                                } label: {
                                    Text("Add New Task").foregroundColor(.white)
                                        .padding().padding(.leading, 50).padding(.trailing,50)
                                        .background(Color("AccentColor")).cornerRadius(30)
                                }.sheet(isPresented: $isAddNewTaskModalPresented) {
                                    AddTaskModalView(setTimeType: $setTimeType)
                                }
                            }.padding(.top, UIScreen.main.bounds.height * 0.05)
                        }
                        Spacer()
                    }
                }
                Spacer()
            }.navigationBarHidden(true)
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar){
                        Button{
                            isAddNewTaskModalPresented.toggle()
                            setTimeType = todayOrUpcoming == 0 ? "Today" : "Upcoming"
                        }label:{
                            Image(systemName: "plus")
                            Text("Add New Task")
                        }.sheet(isPresented: $isAddNewTaskModalPresented) {
                            AddTaskModalView(setTimeType: $setTimeType)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar){
                        Text("")
                    }
                }
                .onAppear(perform: taskVM.reloadAuthorizationStatus).onAppear{
                    WatchConnectivityManager.shared.send(String(UserDefaults(suiteName: "group.com.fergie")!.integer(forKey: "mood")))
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    taskVM.reloadAuthorizationStatus()
                }
                .onReceive(timer){ _ in
                    self.checkTimeLimit = limitFormatter.string(from: Date())
                    if checkTimeLimit == "12:00:00 AM"{
                        limitTask = 10
                    }
                }
                .onChange(of: taskVM.authorizationStatus) { authorizationStatus in
                    switch authorizationStatus {
                    case .notDetermined:
                        taskVM.requestAuthorization()
                    case .authorized:
                        taskVM.reloadLocalNotifications()
                    default:
                        break
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
