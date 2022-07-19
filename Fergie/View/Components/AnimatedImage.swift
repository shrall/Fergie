//
//  AnimatedImage.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 13/07/22.
//

import SwiftUI

struct AnimatedImage: View {
    var imageName: String
    var imageFrames: Int

    @State var activeImageIndex = 0

    let imageSwitchTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        Image("\(imageName)\(activeImageIndex)").resizable().frame(width: 300, height: 300)
            .onReceive(imageSwitchTimer) { _ in
                self.activeImageIndex = (self.activeImageIndex + 1) % imageFrames
            }
    }
}

struct AnimatedImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedImage(imageName: "happyFergieCap", imageFrames: 3)
    }
}
