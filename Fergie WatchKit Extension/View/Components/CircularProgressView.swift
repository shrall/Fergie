//
//  CircularProgressView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 24/06/22.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack (alignment:.top) {
            Circle()
                .stroke(
                    Color("PrimaryColor")
                        .opacity(0.5),
                    lineWidth: 10
                ).frame(width: 120, height: 120)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color("PrimaryColor"),
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                ).frame(width: 120, height: 120)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            Image("moodFace").resizable().frame(width: 24, height: 24).offset(y: -12)
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0)
    }
}
