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
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)], predicate: NSPredicate(format: "date <= %@ && date <= %@", Date() as CVarArg, Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)) var fetchedTasks: FetchedResults<Task>
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily{
        case .systemSmall:
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
                    Spacer()
                    Text("\(fetchedTasks.count) Remaining")
                }.font(Font.system(size: 12))
            }.padding()
        case .systemMedium:
            VStack(alignment:.leading){
                HStack{
                    Text("Today").fontWeight(.bold)
                    Spacer()
                    Image(systemName: "plus.circle")
                }.foregroundColor(.accentColor).font(Font.system(size: 18))
                HStack(spacing:20){
                    VStack(alignment:.leading){
                        VStack{
                            if(fetchedTasks.count > 0){
                                Text(fetchedTasks[0].title!).bold()
                                Text(fetchedTasks[0].date!.showTime())
                            }else{
                                Text("No tasks left\nfor today.")
                            }
                        }
                        Spacer()
                        HStack{
                            Image(systemName: "list.bullet.rectangle.portrait.fill")
                            Text("\(fetchedTasks.count) Remaining")
                        }.font(Font.system(size: 12))
                    }
                    Spacer()
                    VStack(alignment:.center){
                        Image("iconFergieLempeng").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        Text("hohohaha").padding(.top, 4)
                    }
                }
            }.padding()
        case .systemLarge:
            VStack(alignment:.leading){
                HStack{
                    Text("Today").fontWeight(.bold)
                    Spacer()
                    Image(systemName: "plus.circle")
                }.foregroundColor(.accentColor).font(Font.system(size: 18))
                HStack(alignment:.center , spacing:20){
                    VStack(alignment:.leading){
                        Text("Remaining Task(s)").foregroundColor(Color.secondary).font(Font.system(size: 12))
                        Text("\(fetchedTasks.count)").font(Font.system(size: 48))
                    }
                    Spacer()
                    VStack(alignment:.center){
                        Image("iconFergieLempeng").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        Text("hohohaha")
                    }
                }
                if(fetchedTasks.count > 0){
                    ForEach(fetchedTasks.prefix(4).indices, id:\.self){index in
                        HStack{
                            Text(fetchedTasks.prefix(4)[index].title!).fontWeight(index == 0 ? .bold : .none).lineLimit(1)
                            Spacer()
                            Text(fetchedTasks.prefix(4)[index].date!.showTime()).fontWeight(index == 0 ? .bold : .none)
                        }.padding(.vertical, 4).font(Font.system(size: 14))
                        if(fetchedTasks.prefix(4).count - 1 != index ){
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 1.5)
                                .edgesIgnoringSafeArea(.horizontal)
                        }
                    }
                }else{
                    Spacer()
                    Text("No tasks left for today.")
                    Spacer()
                }
            }.padding()
        default:
            Text("default")
        }
    }
}
