//
//  EditAvatarView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 26/06/22.
//

import SwiftUI

class selected: ObservableObject {
    @Published var selectedAccessoryName: String = ""
    @Published var selectedClothingName: String = ""
    @Published var selectedPantsName: String = ""
    @Published var selectedAccessoryImage: String = ""
    @Published var selectedClothingImage: String = ""
    @Published var selectedPantsImage: String = ""
}

struct EditAvatarView: View {
    // Selected
    @ObservedObject var selectedStuff: selected = .init()
    @ObservedObject var userSettings = UserSettings()

    // Coin
    @State private var coin: Int = 150

    // Tabs/Categories
    @State private var accessoriesIsActive: Bool = true
    @State private var clothingIsActive: Bool = false
    @State private var pantsIsActive: Bool = false

    // Navigation Bar
    @State private var hideNavigationbar: Bool = true

    // Navigation Link
    @State private var isAvatarActive: Bool = false

    // Accessories Array
    @State private var accessories: [Accessory] = [
        Accessory(id: 0, name: "cap", iconURL: "accessoriesCapIcon", imageURL: "accessoriesCap"),
        Accessory(id: 1, name: "glasses", iconURL: "accessoriesGlassesIcon", imageURL: "accessoriesGlasses"),
        Accessory(id: 2, name: "sun", iconURL: "accessoriesSunIcon", imageURL: "accessoriesSun"),
        Accessory(id: 3, name: "sunhat", iconURL: "accessoriesSunhatIcon", imageURL: "accessoriesSunhat"),
        Accessory(id: 4, name: "sunglasses", iconURL: "accessoriesSunhatIcon", imageURL: "accessoriesSunglasses")
    ]

    @State private var clothing: [Clothing] = [
        Clothing(id: 0, name: "shirt", iconURL: "clothingShirtIcon", imageURL: "clothingShirt"),
        Clothing(id: 1, name: "yellowShirt", iconURL: "clothingYellowShirtIcon", imageURL: "clothingYellowShirt"),
        Clothing(id: 2, name: "hoodie", iconURL: "clothingHoodieIcon", imageURL: "clothingHoodie"),
        Clothing(id: 3, name: "tee", iconURL: "clothingTeeIcon", imageURL: "clothingTee")
    ]
    @State private var pants: [Pants] = [
        Pants(id: 0, name: "yellow", iconURL: "pantsYellowIcon", imageURL: "pantsYellow"),
        Pants(id: 1, name: "red", iconURL: "pantsRedIcon", imageURL: "pantsRed"),
        Pants(id: 2, name: "string", iconURL: "pantsRedIcon", imageURL: "pantsString"),
        Pants(id: 3, name: "long", iconURL: "pantsRedIcon", imageURL: "pantsLong")
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Fergie").font(.title).fontWeight(.bold)
                    Spacer()
                    HStack {
                        Image("coin")
                        Text(String(coin)).fontWeight(.semibold)
                    }
                }
                .padding(20)
                .padding(.top, -70)
                Spacer()
                ZStack {
                    // Body
                    HStack {
                        Spacer()
                        Image("fergieHappy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                        Spacer()
                    }

                    // Accessories
                    HStack {
                        Spacer()
                        Image(selectedStuff.selectedAccessoryImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                        Spacer()
                    }
                    // Clothing and Pants
                    if selectedStuff.selectedClothingName == "yellowShirt" || selectedStuff.selectedClothingName == "tee" {
                        HStack {
                            Spacer()
                            Image(selectedStuff.selectedClothingImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            Image(selectedStuff.selectedPantsImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
                            Spacer()
                        }
                    } else {
                        HStack {
                            Spacer()
                            Image(selectedStuff.selectedPantsImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Image(selectedStuff.selectedClothingImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
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
                            NavigationLink(destination: AvatarView(), isActive: $isAvatarActive) {
                                EmptyView()
                            }

                            Button {
                                isAvatarActive = true
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
                        Button {} label: {
                            Text("Buy")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .background(.gray)
                        .foregroundColor(.white)
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
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(hideNavigationbar)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            selectedStuff.selectedAccessoryImage = userSettings.accessory
            selectedStuff.selectedClothingImage = userSettings.top
            selectedStuff.selectedPantsImage = userSettings.bottom
        }
    }
}

struct EditAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatarView()
    }
}

struct AccessoriesView: View {
    let accessory: Accessory
    @ObservedObject var selectedStuff: selected
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        Button {
            selectedStuff.selectedAccessoryName = accessory.name
            selectedStuff.selectedAccessoryImage = accessory.imageURL
            userSettings.accessory = accessory.imageURL
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
                    Image("fergieClothingPrice")
                        .resizable()
                        .scaledToFit()
                }.frame(width: 100, height: 100)

                    .background(.white)
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
            selectedStuff.selectedClothingName = clothing.name
            selectedStuff.selectedClothingImage = clothing.imageURL
            userSettings.top = clothing.imageURL
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
                    Image("fergieClothingPrice")
                        .resizable()
                        .scaledToFit()
                }.frame(width: 100, height: 100)

                    .background(.white)
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
            selectedStuff.selectedPantsName = pants.name
            selectedStuff.selectedPantsImage = pants.imageURL
            userSettings.bottom = pants.imageURL
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
                    Image("fergieClothingPrice")
                        .resizable()
                        .scaledToFit()
                }.frame(width: 100, height: 100)
                    .background(.white)
                    .cornerRadius(10)
            }
        }
    }
}
