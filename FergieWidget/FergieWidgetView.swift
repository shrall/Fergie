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
    @State var progressValue: Float = Float(UserDefaults(suiteName: "group.com.fergie")!.integer(forKey: "mood"))/10
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily{
        case .systemSmall:
            VStack(alignment:.leading){
                HStack{
                    Text("Today").fontWeight(.bold)
                    Spacer()
                }.foregroundColor(.accentColor).font(Font.system(size: 18))
                Spacer()
                VStack(alignment: .leading){
                    if(taskViewModel.tasks.count > 0){
                        Text(taskViewModel.tasks[0].title!).bold()
                        Text(taskViewModel.tasks[0].date!.showTime())
                    }else{
                        Text("No tasks left for today.")
                    }
                }
                Spacer()
                HStack{
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("\(taskViewModel.tasks.count) Remaining")
                }.font(Font.system(size: 12))
            }.padding().onAppear{
                taskViewModel.getTodayTasks(context: viewContext)
            }
        case .systemMedium:
            VStack(alignment:.leading){
                HStack{
                    Text("Today").fontWeight(.bold)
                    Spacer()
                }.foregroundColor(.accentColor).font(Font.system(size: 18))
                HStack(spacing:20){
                    VStack(alignment:.leading){
                        VStack(alignment: .leading){
                            if(taskViewModel.tasks.count > 0){
                                Text(taskViewModel.tasks[0].title!).bold()
                                Text(taskViewModel.tasks[0].date!.showTime())
                            }else{
                                Text("No tasks left\nfor today.")
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment:.center){
                        if(progressValue < 0.33){
                            Image("iconFergieSad").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        }else if(progressValue < 0.66){
                            Image("iconFergieLempeng").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        }else{
                            Image("iconFergieHappy").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        }
                    }
                }
                HStack{
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("\(taskViewModel.tasks.count) Remaining")
                }.font(Font.system(size: 12))
            }.padding().onAppear{
                taskViewModel.getTodayTasks(context: viewContext)
            }
        case .systemLarge:
            VStack(alignment:.leading){
                HStack{
                    Text("Today").fontWeight(.bold)
                    Spacer()
                }.foregroundColor(.accentColor).font(Font.system(size: 18))
                HStack(alignment:.center , spacing:20){
                    VStack(alignment:.leading){
                        Text("Remaining Task(s)").foregroundColor(Color.secondary).font(Font.system(size: 12))
                        Text("\(taskViewModel.tasks.count)").font(Font.system(size: 48))
                    }
                    Spacer()
                    VStack(alignment:.center){
                        if(progressValue < 0.33){
                            Image("iconFergieSad").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        }else if(progressValue < 0.66){
                            Image("iconFergieLempeng").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        }else{
                            Image("iconFergieHappy").resizable().frame(width: 100, height: 60, alignment: .trailing)
                        }
                    }
                }
                if(taskViewModel.tasks.count > 0){
                    ForEach(taskViewModel.tasks.prefix(4).indices, id:\.self){index in
                        HStack{
                            Text(taskViewModel.tasks.prefix(4)[index].title!).fontWeight(index == 0 ? .bold : .none).lineLimit(1)
                            Spacer()
                            Text(taskViewModel.tasks.prefix(4)[index].date!.showTime()).fontWeight(index == 0 ? .bold : .none)
                        }.padding(.vertical, 4).font(Font.system(size: 14))
                        if(taskViewModel.tasks.prefix(4).count - 1 != index ){
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
            }.padding().onAppear{
                taskViewModel.getTodayTasks(context: viewContext)
            }
        default:
            Text("default")
        }
    }
}
