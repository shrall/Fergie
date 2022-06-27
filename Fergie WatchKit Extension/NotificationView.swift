//
//  NotificationView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import SwiftUI

struct NotificationView: View {
    var title: String?
    
    var body: some View {
        VStack (alignment:.center) {
            AnimatedImage(imageName: "fergieMood", imageFrames: 3)
            Text("Don't forget about to '\(title ?? "sad")'! Fergie is waiting.")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(title: "Beli Sayur")
    }
}
