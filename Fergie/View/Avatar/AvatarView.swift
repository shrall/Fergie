//
//  AvatarView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 22/06/22.
//

import SwiftUI

struct AvatarView: View {
    @State private var coin: Int = 150
    @State private var happiness: Double = 5
    private let maxValue: Double = 10

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack {
                    // body
                    HStack {
                        Spacer()
                        Image("fergieNeutral")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Spacer()
                    }
                }
                Spacer()
                Button("Customize") {
                    print("Button pressed!")
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(Color.ui.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                VStack {
                    Text("Happiness Meter").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Image("happinessMeter")
                        ProgressBar(value: $happiness.wrappedValue,
                                    maxValue: self.maxValue,
                                    foregroundColor: Color.ui.yellow)
                            .frame(height: 10)
                            .padding(10)
                    }
                }
                .padding(20)
                .background(Color.ui.gray)
                .cornerRadius(8)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Fergie").font(.title).fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image("coin")
                        Text(String(coin)).fontWeight(.semibold)
                    }
                }
            }
            .padding(20)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

extension Color {
    static let ui = Color.UI()

    struct UI {
        let gray = Color("GrayColor")
        let yellow = Color("PrimaryColor")
        let blue = Color("AccentColor")
    }
}
