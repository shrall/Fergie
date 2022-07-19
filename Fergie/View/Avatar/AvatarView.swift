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
                    if happiness >= 0, happiness <= 3 {
                        if isDetectingPress == true {
                            EmptyView().onAppear { print(isDetectingPress) }
                            Image("fergieTappedSad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        } else {
                            EmptyView().onAppear { print(isDetectingPress) }
                            if userSettings.accessory == "accessoriesGlasses" {
                                AnimatedImage(imageName: "sadFergieGlasses", imageFrames: 160)
                            } else if userSettings.accessory == "accessoriesSunglasses" {
                                AnimatedImage(imageName: "sadFergieSunglasses", imageFrames: 160)
                            } else {
                                AnimatedImage(imageName: "sadFergieNone", imageFrames: 160)
                            }
                        }
                        
                    } else if happiness > 3, happiness <= 6 {
                        if isDetectingPress == true {
                            EmptyView().onAppear { print(isDetectingPress) }
                            Image("fergieTappedNeutral")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        } else {
                            AnimatedImage(imageName: "neutralFergieNone", imageFrames: 84)
                        }
                    } else {
                        if isDetectingPress == true {
                            EmptyView().onAppear { print(isDetectingPress) }
                            Image("fergieTappedHappy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        } else {
                            if userSettings.accessory == "accessoriesCap" {
                                AnimatedImage(imageName: "happyFergieCap", imageFrames: 160)
                            } else if userSettings.accessory == "accessoriesGlasses" {
                                AnimatedImage(imageName: "happyFergieGlasses", imageFrames: 160)
                            } else if userSettings.accessory == "accessoriesSun" {
                                AnimatedImage(imageName: "happyFergieSun", imageFrames: 160)
                            } else if userSettings.accessory == "accessoriesSunhat" {
                                AnimatedImage(imageName: "happyFergieSunhat", imageFrames: 160)
                            } else if userSettings.accessory == "accessoriesSunglasses" {
                                AnimatedImage(imageName: "happyFergieSunglasses", imageFrames: 160)
                            } else {
                                AnimatedImage(imageName: "happyFergieNone", imageFrames: 160).onAppear {
                                    print(userSettings.accessory)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                if happiness >= 0, happiness <= 3 {
                    if userSettings.accessory == "" || userSettings.accessory == "accessoriesSun" || userSettings.accessory == "accessoriesSunhat" || userSettings.accessory == "accessoriesCap" {
                        HStack {
                            Spacer()
                            Image(userSettings.accessory)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
                                .padding(.top, 16)
                                .padding(.leading, 12)
                            Spacer()
                        }
                    } else if userSettings.accessory == "accessoriesGlasses" || userSettings.accessory == "accessoriesSunglasses" {
                        if isDetectingPress == true {
                            HStack {
                                Spacer()
                                Image(userSettings.accessory)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 260)
                                    .padding(.top, 12)
                                Spacer()
                            }
                        }
                    }
                } else if happiness > 3, happiness <= 6 {
                    // Accessory
                    HStack {
                        Spacer()
                        Image(userSettings.accessory)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                            .padding(.top, 12)
                        Spacer()
                    }
                } else if happiness > 6, happiness <= 10 {
                    // Accessory
                    if isDetectingPress == true {
                        HStack {
                            Spacer()
                            Image(userSettings.accessory)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
                                .padding(.top, 12)
                            Spacer()
                        }
                    }
                } else {
                    EmptyView()
                }
               
                // Clothing and Pants
                if userSettings.top == "clothingYellowShirt" || userSettings.top == "clothingTee" {
                    HStack {
                        Spacer()
                        Image(userSettings.top)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                        Spacer()
                    }
                    .padding(.leading, 2)
                    .padding(.top, 4)
                    
                    HStack {
                        Spacer()
                        Image(userSettings.bottom)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 264)
                        Spacer()
                    }
                    .padding(.leading, 2)
                    .padding(.top, -16)
                    
                } else {
                    HStack {
                        Spacer()
                        Image(userSettings.bottom)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 264)
                        Spacer()
                    }
                    .padding(.leading, 2)
                    .padding(.top, -16)
                    
                    HStack {
                        Spacer()
                        Image(userSettings.top)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                        Spacer()
                    }
                    .padding(.leading, 2)
                    .padding(.top, 4)
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
    
            ZStack {
                NavigationLink(destination: EditAvatarView(userSettingsSave: userSettings)) {
                    Text("Customize your Fergie")
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(Color.ui.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                ZStack {
                    Circle()
                        .fill(Color.ui.blue)
                        .frame(width: 55, height: 55)
                    Circle()
                        .fill(Color.ui.white)
                        .frame(width: 40, height: 40)
                    Image("customizeIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)
            }
        
            Spacer()
        }
        .padding(20)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .onAppear {
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
