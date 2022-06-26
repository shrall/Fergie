//
//  AvatarView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 22/06/22.
//

import SwiftUI

struct AvatarView: View {
    @State private var showSheet: Bool = false
    @State private var coin: Int = 150
    @State private var happiness: Double = 5
    @State private var maxValue: Double = 10
//    @State private var accessoriesIsActive: Bool = true
//    @State private var clothingIsActive: Bool = false
//    @State private var pantsIsActive: Bool = false
    @State private var isEditAvatarActive: Bool = false
    @GestureState private var isDetectingPress = false

    @State private var accessories: [Accessory] = [
        Accessory(id: 0, name: "cap", imageURL: "accessoriesCap"),
        Accessory(id: 1, name: "glasses", imageURL: "accessoriesGlasses"),
        Accessory(id: 2, name: "sun", imageURL: "accessoriesSun"),
        Accessory(id: 3, name: "sunhat", imageURL: "accessoriesSunhat"),
        Accessory(id: 4, name: "sunglasses", imageURL: "accessoriesSunglasses")
    ]

    @State private var clothing: [Clothing] = [
        Clothing(id: 0, name: "shirt", imageURL: "clothingShirt"),
        Clothing(id: 1, name: "yellowShirt", imageURL: "clothingYellowShirt"),
        Clothing(id: 2, name: "hoodie", imageURL: "clothingHoodie"),
        Clothing(id: 3, name: "tee", imageURL: "clothingTee")
    ]
    @State private var pants: [Pants] = [
        Pants(id: 0, name: "yellow", imageURL: "pantsYellow"),
        Pants(id: 1, name: "red", imageURL: "pantsRed"),
        Pants(id: 2, name: "string", imageURL: "pantsString"),
        Pants(id: 3, name: "long", imageURL: "pantsLong")
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("happinessMeter")
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
                    // body
                    HStack {
                        Spacer()
                        Image(isDetectingPress == true ? "fergieTappedHappy" : "fergieHappy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Spacer()
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

                NavigationLink(destination: EditAvatarView(), isActive: $isEditAvatarActive) {
                    EmptyView()
                }

                Button("Customize Your Fergie!") {
//                    showSheet.toggle()
                    isEditAvatarActive = true
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(Color.ui.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .center)
//                .halfSheet(showSheet: $showSheet) {
//                    // Half Sheet View
//                    ZStack {
//                        Color.ui.gray
//                            .ignoresSafeArea()
//                        VStack {
//                            HStack {
//                                Text("Customize").font(.title).fontWeight(.bold)
//                                Spacer()
//                                Button {
//                                    showSheet.toggle()
//                                } label: {
//                                    Image(systemName: "multiply")
//                                }
//                                .padding(10)
//                                .background(Color.ui.lightRed)
//                                .foregroundColor(Color.ui.red)
//                                .clipShape(Circle())
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                            }
//
//                            HStack {
//                                if accessoriesIsActive {
//                                    Button {
//                                        print("Accessories")
//                                        accessoriesIsActive = true
//                                        clothingIsActive = false
//                                        pantsIsActive = false
//                                    } label: {
//                                        Text("Accessories").font(.caption)
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 10)
//                                    .background(Color.ui.blue)
//                                    .foregroundColor(.white)
//                                    .clipShape(Capsule())
//                                    .frame(maxWidth: .infinity)
//                                } else {
//                                    Button {
//                                        print("Accessories")
//                                        accessoriesIsActive = true
//                                        clothingIsActive = false
//                                        pantsIsActive = false
//                                    } label: {
//                                        Text("Accessories").font(.caption)
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 10)
//                                    .background(.clear)
//                                    .foregroundColor(Color.ui.blue)
//                                    .clipShape(Capsule())
//                                    .frame(maxWidth: .infinity)
//                                }
//                                if clothingIsActive {
//                                    Button {
//                                        print("Clothing")
//                                        accessoriesIsActive = false
//                                        clothingIsActive = true
//                                        pantsIsActive = false
//                                    } label: {
//                                        Text("Clothing").font(.caption)
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 10)
//                                    .background(Color.ui.blue)
//                                    .foregroundColor(.white)
//                                    .clipShape(Capsule())
//                                    .frame(maxWidth: .infinity)
//                                } else {
//                                    Button {
//                                        print("Clothing")
//                                        accessoriesIsActive = false
//                                        clothingIsActive = true
//                                        pantsIsActive = false
//                                        print(clothingIsActive)
//                                    } label: {
//                                        Text("Clothing").font(.caption)
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 10)
//                                    .background(.clear)
//                                    .foregroundColor(Color.ui.blue)
//                                    .clipShape(Capsule())
//                                    .frame(maxWidth: .infinity)
//                                }
//                                if pantsIsActive {
//                                    Button {
//                                        print("Pants")
//                                        accessoriesIsActive = false
//                                        clothingIsActive = false
//                                        pantsIsActive = true
//
//                                    } label: {
//                                        Text("Pants").font(.caption)
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 10)
//                                    .background(Color.ui.blue)
//                                    .foregroundColor(.white)
//                                    .clipShape(Capsule())
//                                    .frame(maxWidth: .infinity)
//                                } else {
//                                    Button {
//                                        print("Pants")
//                                        accessoriesIsActive = false
//                                        clothingIsActive = false
//                                        pantsIsActive = true
//                                        print(pantsIsActive)
//                                    } label: {
//                                        Text("Pants").font(.caption)
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 10)
//                                    .background(.clear)
//                                    .foregroundColor(Color.ui.blue)
//                                    .clipShape(Capsule())
//                                    .frame(maxWidth: .infinity)
//                                }
//                            }
//                            Spacer()
//                                .frame(height: 20)
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                if accessoriesIsActive {
//                                    HStack {
//                                        ForEach(accessories) { accessory in
//                                            AccessoriesView(accessory: accessory)
//                                        }
//                                    }
//                                }
//                                if clothingIsActive {
//                                    HStack {
//                                        ForEach(clothing) { clothing in
//                                            ClothingView(clothing: clothing)
//                                        }
//                                    }
//                                }
//
//                                if pantsIsActive {
//                                    HStack {
//                                        ForEach(pants) { pants in
//                                            PantsView(pants: pants)
//                                        }
//                                    }
//                                }
//                            }
//                            Spacer()
//                            Button {
//                                showSheet.toggle()
//                            } label: {
//                                Text("Buy")
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                            }
//                            .padding(.horizontal, 25)
//                            .padding(.vertical, 10)
//                            .background(.gray)
//                            .foregroundColor(.white)
//                            .clipShape(Capsule())
//
//                            Spacer()
//
//                        }.padding(20)
//                    }
//
//                } onEnd: {
//                    print("Dismissed")
//                }
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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

extension Color {
    static let ui = Color.UI()

    struct UI {
        let gray = Color("GrayColor")
        let yellow = Color("PrimaryColor")
        let blue = Color("AccentColor")
        let red = Color("RedColor")
        let lightRed = Color("LightRedColor")
    }
}
