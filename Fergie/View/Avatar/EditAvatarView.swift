//
//  EditAvatarView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 26/06/22.
//

import AVFoundation
import SwiftUI

class selected: ObservableObject {
    @Published var selectedAccessoryName: String = ""
    @Published var selectedClothingName: String = ""
    @Published var selectedPantsName: String = ""
    @Published var selectedAccessoryImage: String = ""
    @Published var selectedClothingImage: String = ""
    @Published var selectedPantsImage: String = ""
    @Published var isOwned: Bool = false
    @Published var isHaveEnoughMoney: Bool = false
    @Published var selectedBuyItem: String = ""
}

struct EditAvatarView: View {
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

//    @Binding var isShowEditAvatarView: Bool

    // Sound
    @State private var player: AVAudioPlayer?

    // Selected
    @ObservedObject var selectedStuff: selected = .init()
    @ObservedObject var userSettingsSave: UserSettings
    @ObservedObject var userSettings = UserSettings()

    // Tabs/Categories
    @State private var accessoriesIsActive: Bool = true
    @State private var clothingIsActive: Bool = false
    @State private var pantsIsActive: Bool = false

    // Navigation Link
    @State private var isAvatarActive: Bool = false

    // Accessories Array
    @State private var accessories: [Accessory] = [
        Accessory(id: 0, name: "none", iconURL: "noSignIcon", imageURL: "", price: 0),
        Accessory(id: 1, name: "cap", iconURL: "accessoriesCapIcon", imageURL: "accessoriesCap", price: 200),
        Accessory(id: 2, name: "glasses", iconURL: "accessoriesGlassesIcon", imageURL: "accessoriesGlasses", price: 200),
        Accessory(id: 3, name: "sun", iconURL: "accessoriesSunIcon", imageURL: "accessoriesSun", price: 200),
        Accessory(id: 4, name: "sunhat", iconURL: "accessoriesSunhatIcon", imageURL: "accessoriesSunhat", price: 200),
        Accessory(id: 5, name: "sunglasses", iconURL: "accessoriesSunglassesIcon", imageURL: "accessoriesSunglasses", price: 200)
    ]

    @State private var clothing: [Clothing] = [
        Clothing(id: 0, name: "none", iconURL: "noSignIcon", imageURL: "", price: 0),
        Clothing(id: 1, name: "shirt", iconURL: "clothingShirtIcon", imageURL: "clothingShirt", price: 200),
        Clothing(id: 2, name: "yellowShirt", iconURL: "clothingYellowShirtIcon", imageURL: "clothingYellowShirt", price: 200),
        Clothing(id: 3, name: "hoodie", iconURL: "clothingHoodieIcon", imageURL: "clothingHoodie", price: 200),
        Clothing(id: 4, name: "tee", iconURL: "clothingTeeIcon", imageURL: "clothingTee", price: 200)
    ]
    @State private var pants: [Pants] = [
        Pants(id: 0, name: "none", iconURL: "noSignIcon", imageURL: "", price: 200),
        Pants(id: 1, name: "yellow", iconURL: "pantsYellowIcon", imageURL: "pantsYellow", price: 200),
        Pants(id: 2, name: "red", iconURL: "pantsRedIcon", imageURL: "pantsRed", price: 200),
        Pants(id: 3, name: "string", iconURL: "pantsStringIcon", imageURL: "pantsString", price: 200),
        Pants(id: 4, name: "long", iconURL: "pantsLongIcon", imageURL: "pantsLong", price: 200)
    ]

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
            .padding(20)
            Spacer()
            ZStack {
                // Body
                HStack {
                    Spacer()
                    if userSettings.mood <= 3 {
                        Image("fergieSad")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    } else if userSettings.mood <= 6 {
                        Image("fergieNeutral")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    } else {
                        Image("fergieHappy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                    Spacer()
                }

                // Accessories
                HStack {
                    Spacer()
                    Image(selectedStuff.selectedAccessoryImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 255)
                        .padding(.top, 10)
                    Spacer()
                }
                // Clothing and Pants
                if selectedStuff.selectedClothingImage == "clothingYellowShirt" || selectedStuff.selectedClothingImage == "clothingTee" {
                    HStack {
                        Spacer()
                        Image(selectedStuff.selectedClothingImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.leading, 2)
                            .frame(width: 255)
                            .padding(.top, 2)
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        Image(selectedStuff.selectedPantsImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.leading, 2)
                            .frame(width: 255)
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        Image(selectedStuff.selectedPantsImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.leading, 2)
                            .frame(width: 255)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Image(selectedStuff.selectedClothingImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.leading, 2)
                            .frame(width: 255)
                            .padding(.top, 2)
                        Spacer()
                    }
                }
            }
            Spacer()
            ZStack {
                Color.ui.gray
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Customize").font(.title).fontWeight(.bold)
                        Spacer()
//                        NavigationLink(destination: AvatarView(), isActive: $isAvatarActive) {
//                            EmptyView()
//                        }

                        Button {
//                            print(isShowEditAvatarView)
//                            isShowEditAvatarView = false
//                            print(isShowEditAvatarView)
//                            isAvatarActive = true
//                            presentationMode.wrappedValue.dismiss()
                            userSettingsSave.accessory = userSettings.accessory
                            userSettingsSave.ownedAccessories = userSettings.ownedAccessories
                            userSettingsSave.top = userSettings.top
                            userSettingsSave.ownedTops = userSettings.ownedTops
                            userSettingsSave.bottom = userSettings.bottom
                            userSettingsSave.ownedBottoms = userSettings.ownedBottoms
                            userSettingsSave.coin = userSettings.coin
                            userSettingsSave.objectWillChange.send()
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .padding(10)
                        .background(Color.ui.lightRed)
                        .foregroundColor(Color.ui.red)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.top, 20)

                    HStack {
                        if accessoriesIsActive {
                            Button {
                                print("Accessories")
                                accessoriesIsActive = true
                                clothingIsActive = false
                                pantsIsActive = false
                            } label: {
                                Text("Accessories").font(.caption)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.ui.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        } else {
                            Button {
                                print("Accessories")
                                accessoriesIsActive = true
                                clothingIsActive = false
                                pantsIsActive = false
                            } label: {
                                Text("Accessories").font(.caption)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.clear)
                            .foregroundColor(Color.ui.blue)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        }
                        if clothingIsActive {
                            Button {
                                print("Clothing")
                                accessoriesIsActive = false
                                clothingIsActive = true
                                pantsIsActive = false
                            } label: {
                                Text("Clothing").font(.caption)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.ui.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        } else {
                            Button {
                                print("Clothing")
                                accessoriesIsActive = false
                                clothingIsActive = true
                                pantsIsActive = false
                                print(clothingIsActive)
                            } label: {
                                Text("Clothing").font(.caption)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.clear)
                            .foregroundColor(Color.ui.blue)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        }
                        if pantsIsActive {
                            Button {
                                print("Pants")
                                accessoriesIsActive = false
                                clothingIsActive = false
                                pantsIsActive = true

                            } label: {
                                Text("Pants").font(.caption)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.ui.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        } else {
                            Button {
                                print("Pants")
                                accessoriesIsActive = false
                                clothingIsActive = false
                                pantsIsActive = true
                                print(pantsIsActive)
                            } label: {
                                Text("Pants").font(.caption)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.clear)
                            .foregroundColor(Color.ui.blue)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        }
                    }
                    Spacer()
                        .frame(height: 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        if accessoriesIsActive {
                            HStack {
                                ForEach(accessories) { accessory in
                                    AccessoriesView(accessory: accessory, selectedStuff: selectedStuff, userSettings: userSettings)
                                }
                            }
                        }
                        if clothingIsActive {
                            HStack {
                                ForEach(clothing) { clothing in
                                    ClothingView(clothing: clothing, selectedStuff: selectedStuff, userSettings: userSettings)
                                }
                            }
                        }

                        if pantsIsActive {
                            HStack {
                                ForEach(pants) { pants in
                                    PantsView(pants: pants, selectedStuff: selectedStuff, userSettings: userSettings)
                                }
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 30)
                    Button {
                        if selectedStuff.isOwned == false, selectedStuff.isHaveEnoughMoney == true {
                            if accessories.contains(where: { accessory in accessory.imageURL == selectedStuff.selectedBuyItem }) {
                                userSettings.ownedAccessories.append(selectedStuff.selectedBuyItem)
                                userSettings.accessory = selectedStuff.selectedBuyItem
                                if selectedStuff.selectedBuyItem == "" {
                                    userSettings.coin = userSettings.coin - 0
                                } else {
                                    playCoinSound()
                                    userSettings.coin = userSettings.coin - 200
                                }

                            } else if clothing.contains(where: { clothing in clothing.imageURL == selectedStuff.selectedBuyItem }) {
                                userSettings.ownedTops.append(selectedStuff.selectedBuyItem)
                                userSettings.top = selectedStuff.selectedBuyItem
                                if selectedStuff.selectedBuyItem == "" {
                                    userSettings.coin = userSettings.coin - 0
                                } else {
                                    playCoinSound()
                                    userSettings.coin = userSettings.coin - 200
                                }

                            } else if pants.contains(where: { pants in pants.imageURL == selectedStuff.selectedBuyItem }) {
                                userSettings.ownedBottoms.append(selectedStuff.selectedBuyItem)
                                userSettings.bottom = selectedStuff.selectedBuyItem
                                if selectedStuff.selectedBuyItem == "" {
                                    userSettings.coin = userSettings.coin - 0
                                } else {
                                    playCoinSound()
                                    userSettings.coin = userSettings.coin - 200
                                }
                            }
                        }

                    } label: {
                        Text("Buy")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background((selectedStuff.isOwned == false && selectedStuff.isHaveEnoughMoney == false) || selectedStuff.isOwned == true ? Color.ui.darkGray : Color.ui.blue)
                    .foregroundColor((selectedStuff.isOwned == false && selectedStuff.isHaveEnoughMoney == false) || selectedStuff.isOwned == true ? Color.ui.white : .white)
                    .clipShape(Capsule())

                }.padding(20)
            }
            .frame(width: .infinity, height: 300)
            .padding(.bottom, 20)
            .cornerRadius(20)
            .padding(.bottom, -30)
        }
        .frame(maxWidth: .infinity, // Full Screen Width
               maxHeight: .infinity, // Full Screen Height
               alignment: .topLeading) // Align To top
//        .navigationBarTitle("")
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
        .onAppear {
            selectedStuff.selectedAccessoryImage = userSettings.accessory
            selectedStuff.selectedClothingImage = userSettings.top
            selectedStuff.selectedPantsImage = userSettings.bottom
        }
    }

    func playCoinSound() {
        guard let path = Bundle.main.path(forResource: "coinSFX", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("play!")

        } catch {
            print(error.localizedDescription)
        }
    }

//    func updateView() {
//        self.objectWillChange.send()
//    }
}

struct EditAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatarView(userSettingsSave: UserSettings(), userSettings: UserSettings())
    }
}

struct AccessoriesView: View {
    let accessory: Accessory
    @ObservedObject var selectedStuff: selected
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        Button {
            print(userSettings.ownedAccessories)
            if userSettings.ownedAccessories.contains(accessory.imageURL) {
                selectedStuff.isOwned = true
                selectedStuff.isHaveEnoughMoney = false
                userSettings.accessory = accessory.imageURL
            } else {
                if userSettings.coin >= 200 {
                    selectedStuff.isHaveEnoughMoney = true
                    selectedStuff.isOwned = false
                    selectedStuff.selectedBuyItem = accessory.imageURL
                }
            }
            selectedStuff.selectedAccessoryName = accessory.name
            selectedStuff.selectedAccessoryImage = accessory.imageURL

        } label: {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Image(accessory.iconURL)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    if userSettings.ownedAccessories.contains(accessory.imageURL) || accessory.name == "none" {
                        EmptyView()
                    } else {
                        Image("fergieClothingPrice")
                            .resizable()
                            .scaledToFit()
                    }
                }.frame(width: 100, height: 100)

                    .background(Color.ui.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct ClothingView: View {
    let clothing: Clothing
    @ObservedObject var selectedStuff: selected
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        Button {
            if userSettings.ownedTops.contains(clothing.imageURL) {
                selectedStuff.isOwned = true
                selectedStuff.isHaveEnoughMoney = false
                userSettings.top = clothing.imageURL
            } else {
                if userSettings.coin >= 200 {
                    selectedStuff.isHaveEnoughMoney = true
                    selectedStuff.isOwned = false
                    selectedStuff.selectedBuyItem = clothing.imageURL
                }
            }
            selectedStuff.selectedClothingName = clothing.name
            selectedStuff.selectedClothingImage = clothing.imageURL

        } label: {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Image(clothing.iconURL)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    if userSettings.ownedTops.contains(clothing.imageURL) || clothing.name == "none" {
                        EmptyView()
                    } else {
                        Image("fergieClothingPrice")
                            .resizable()
                            .scaledToFit()
                    }
                }.frame(width: 100, height: 100)

                    .background(Color.ui.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct PantsView: View {
    let pants: Pants
    @ObservedObject var selectedStuff: selected
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        Button {
            if userSettings.ownedBottoms.contains(pants.imageURL) {
                selectedStuff.isOwned = true
                selectedStuff.isHaveEnoughMoney = false
                userSettings.bottom = pants.imageURL
            } else {
                if userSettings.coin >= 200 {
                    selectedStuff.isHaveEnoughMoney = true
                    selectedStuff.isOwned = false
                    selectedStuff.selectedBuyItem = pants.imageURL
                }
            }
            selectedStuff.selectedPantsName = pants.name
            selectedStuff.selectedPantsImage = pants.imageURL

        } label: {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Image(pants.iconURL)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    if userSettings.ownedBottoms.contains(pants.imageURL) || pants.name == "none" {
                        EmptyView()
                    } else {
                        Image("fergieClothingPrice")
                            .resizable()
                            .scaledToFit()
                    }

                }.frame(width: 100, height: 100)
                    .background(Color.ui.white)
                    .cornerRadius(10)
            }
        }
    }
}
