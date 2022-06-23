//
//  OnboardingView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 22/06/22.
//

import SwiftUI

struct OnboardingView: View {
    @State var isLinkActive = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image("fergieDancing")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Spacer()
                }
                Spacer()
                    .frame(height: 20)
                Text("Meet Fergie the Cloud.").fontWeight(.semibold)
                Spacer()
                    .frame(height: 10)
                Text("Let's cheer you on doing your daily tasks!")
                Spacer()
                    .frame(height: 70)

                NavigationLink(destination: ContentView(), isActive: $isLinkActive) {
                    Button(action: {
                        self.isLinkActive = true
                    }) {
                        Text("Get Started")
                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(Color.ui.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
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
