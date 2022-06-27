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
            AnimatedImage(imageName: "fergieNotification", imageFrames: 30)
            Text("Don't forget to \(title ?? "sad")!\nFergie is waiting.")
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
