//
//  FergieMoodView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 24/06/22.
//

import SwiftUI

struct FergieMoodView: View {
    @State var progressValue: Float = Float(UserDefaults.standard.integer(forKey: "mood"))/10
    @State var fergieClicked = false
    
    var body: some View {
        VStack(spacing:8){
            Spacer()
            HStack(spacing:8){
                Image("moodFace").resizable().frame(width: 24, height: 24)
                LinearProgressView(value: $progressValue).frame(height:12)
            }.frame(width:150)
            if(progressValue < 0.33){
                if(!fergieClicked){
                    AnimatedImage(imageName: "fergieSad", imageFrames: 80).onTapGesture {
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
                Text("Fergie is feeling bored.")
            }else{
                if(!fergieClicked){
                    AnimatedImage(imageName: "fergieHappy", imageFrames: 80).onTapGesture {
                        fergieClicked = true
                    }
                }else{
                    Image("fergieHappyClicked").resizable().frame(width: 120, height: 100).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fergieClicked = false
                        }
                    }
                }
                Text("Fergie is now happy!")
            }
        }.onAppear{
            UserDefaults.standard.set(6, forKey: "mood")
            print(Double(UserDefaults.standard.integer(forKey: "mood"))/10)
        }
    }
}

struct FergieMoodView_Previews: PreviewProvider {
    static var previews: some View {
        FergieMoodView()
    }
}
