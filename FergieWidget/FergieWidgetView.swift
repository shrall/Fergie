//
//  FergieWidgetView.swift
//  FergieWidgetExtension
//
//  Created by Marshall Kurniawan on 29/06/22.
//

import WidgetKit
import SwiftUI

struct FergieWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)], predicate: NSPredicate(format: "date >= %@ && date <= %@", Date() as CVarArg, Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)) var fetchedTasks: FetchedResults<Task>
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("Today").fontWeight(.bold)
                Spacer()
                Image(systemName: "plus.circle")
            }.foregroundColor(.accentColor).font(Font.system(size: 18))
            Spacer()
            VStack{
                if(fetchedTasks.count > 0){
                    Text(fetchedTasks[0].title!).bold()
                    Text(fetchedTasks[0].date!.showTime())
                }else{
                    Text("No tasks left for today.")
                }
            }
            Spacer()
            HStack{
                Image(systemName: "list.bullet.rectangle.portrait.fill")
                Text("\(fetchedTasks.count) Remaining")
            }.font(Font.system(size: 12))
        }.padding()
    }
}
