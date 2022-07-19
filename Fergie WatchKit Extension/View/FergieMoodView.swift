//
//  FergieMoodView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 24/06/22.
//

import SwiftUI

struct FergieMoodView: View {
    @State var progressValue: Float = Float(UserDefaults(suiteName: "group.com.fergie")!.integer(forKey: "mood"))/10
    @State var fergieClicked = false
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    
    var body: some View {
        VStack(spacing:8){
            Spacer()
            HStack(spacing:8){
                Image("moodFace").resizable().frame(width: 24, height: 24)
                LinearProgressView(value: $progressValue).frame(height:12)
            }.frame(width:150)
            if(progressValue < 0.33){
                if(!fergieClicked){
                    AnimatedImage(imageName: "fergieSad", imageFrames: 145).onTapGesture {
                        fergieClicked = true
                    }
                }else{
                    Image("fergieSadClicked").resizable().frame(width: 120, height: 100).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fergieClicked = false
                        }
                    }
                }
                Text("Fergie is sad.")
            }else if(progressValue < 0.66){
                if(!fergieClicked){
                    AnimatedImage(imageName: "fergieLempeng", imageFrames: 80).onTapGesture {
                        fergieClicked = true
                    }
                }else{
                    Image("fergieLempengClicked").resizable().frame(width: 120, height: 100).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fergieClicked = false
                        }
                    }
                }
                Text("Fergie is bored.")
            }else{
                if(!fergieClicked){
                    AnimatedImage(imageName: "fergieHappy", imageFrames: 143).onTapGesture {
                        fergieClicked = true
                    }
                }else{
                    Image("fergieHappyClicked").resizable().frame(width: 120, height: 100).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fergieClicked = false
                        }
                    }
                }
                Text("Fergie is happy!")
            }
        }.onAppear{
            if(connectivityManager.moodValue != nil){
                userSettings.mood = Double(connectivityManager.moodValue ?? "0")!
            }
            progressValue = Float(userSettings.mood)/10
        }
    }
}

struct FergieMoodView_Previews: PreviewProvider {
    static var previews: some View {
        FergieMoodView()
    }
}
