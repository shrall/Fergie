//
//  AvatarView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 22/06/22.
//

import SwiftUI

struct AvatarView: View {
    @State private var isPresented = false
    
//    @Binding var isShowAvatarView: Bool
    
    // Hour
    let hour = Calendar.current.component(.hour, from: Date())
    
    // USer Defaults
    @StateObject var userSettings = UserSettings()
    
    // Half Sheet Modal
    @State private var showSheet: Bool = false
    
    // Coin
    @State private var coin: Int = 0
    
    // Happiness Meter
    @State private var happiness: Double = 0
    @State private var maxValue: Double = 10
    
    // Navigation Link
    @State private var isEditAvatarActive: Bool = false
    
    // Gesture Detector
    @GestureState private var isDetectingPress = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Fergie").font(.title).fontWeight(.bold)
                Spacer()
                HStack {
                    Image("coin")
                    Text(String(userSettings.coin)).fontWeight(.semibold)
                }
            }
            Spacer()
            HStack {
                Spacer()
                Image("happinessIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                ProgressBar(value: $happiness.wrappedValue,
                            maxValue: self.maxValue,
                            foregroundColor: Color.ui.yellow)
                    .frame(width: 200, height: 20)
                    .padding(10)
                Spacer()
            }
            Spacer()
            ZStack {
                // Body
                HStack {
                    Spacer()
                    if happiness >= 0 && happiness <= 3 {
                        Image(isDetectingPress == true ? "fergieTappedSad" : "fergieSad")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    } else if happiness > 3 && happiness <= 6 {
                        Image(isDetectingPress == true ? "fergieTappedNeutral" : "fergieNeutral")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    } else {
                        Image(isDetectingPress == true ? "fergieTappedHappy" : "fergieHappy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                    Spacer()
                }
                
                // Accessory
                HStack {
                    Spacer()
                    Image(userSettings.accessory)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                    Spacer()
                }
                
                // Clothing and Pants
                if userSettings.top == "clothingYellowShirt" || userSettings.top == "clothingTee" {
                    HStack {
                        Spacer()
                        Image(userSettings.top)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Image(userSettings.bottom)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        Image(userSettings.bottom)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Image(userSettings.top)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                        Spacer()
                    }
                }
            }
            .gesture(LongPressGesture(minimumDuration: 0.1).sequenced(before: DragGesture(minimumDistance: 0))
                .updating($isDetectingPress) { value, state, _ in
                    switch value {
                    case .second(true, nil):
                        state = true
                    default:
                        break
                    }
                })
            Spacer()
    
            NavigationLink(destination: EditAvatarView(userSettingsSave: userSettings)) {
                Text("Customize your Fergie")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.ui.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        
            Spacer()
        }
        .padding(20)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .onAppear {
            userSettings.coin = 1500
            coin = userSettings.coin
            happiness = userSettings.mood
            checkMood()
        }
    }

    func checkMood() {
        if hour == 0 || hour == 6 || hour == 12 || hour == 18 || hour == 24 {
            happiness = happiness - 1
            happiness = userSettings.mood
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

// Custom Half Modal Sheet Modifier
extension View {
    // Binding Show Variable
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView, onEnd: @escaping () -> ()) -> some View {
        return background(
            HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd)
        )
    }
}

// UIKit Integration
struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onEnd: () -> ()
    
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
            
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
    
    // OnDismiss..
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
}

// Custom UIHostingController for halfSheet
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium()
            ]
        }
    }
}
