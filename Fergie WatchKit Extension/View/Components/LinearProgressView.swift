//
//  LinearProgressView.swift
//  Fergie WatchKit Extension
//
//  Created by Marshall Kurniawan on 24/06/22.
//

import SwiftUI

struct LinearProgressView: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color("PrimaryColor"))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("PrimaryColor"))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct LinearProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LinearProgressView(value: .constant(0.2))
    }
}
