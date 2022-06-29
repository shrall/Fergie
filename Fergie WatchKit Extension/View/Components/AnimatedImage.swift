//
//  AnimatedImage.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 27/06/22.
//

import SwiftUI

struct AnimatedImage: View {
    var imageName:String
    var imageFrames:Int
    
    @State var activeImageIndex = 0

    let imageSwitchTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image("\(imageName)\(activeImageIndex)").resizable().frame(width: 120, height: 100)
            .onReceive(imageSwitchTimer) { _ in
                self.activeImageIndex = (self.activeImageIndex + 1) % imageFrames
            }
    }
}

struct AnimatedImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedImage(imageName: "fergieMood", imageFrames: 3)
    }
}
