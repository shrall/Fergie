//
//  EditAvatarView.swift
//  Fergie
//
//  Created by Tinara Nathania Wiryonoputro on 26/06/22.
//

import SwiftUI

struct EditAvatarView: View {
    @State private var coin: Int = 150
    @State private var accessoriesIsActive: Bool = true
    @State private var clothingIsActive: Bool = false
    @State private var pantsIsActive: Bool = false
    @State private var hideNavigationbar: Bool = true
    @State private var isAvatarActive: Bool = false
   

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
//                .background(.red)
                Spacer()
                ZStack {
                    // body
                    HStack {
                        Spacer()
                        Image("fergieNeutral")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                        Spacer()
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
                                        AccessoriesView(accessory: accessory)
                                    }
                                }
                            }
                            if clothingIsActive {
                                HStack {
                                    ForEach(clothing) { clothing in
                                        ClothingView(clothing: clothing)
                                    }
                                }
                            }

                            if pantsIsActive {
                                HStack {
                                    ForEach(pants) { pants in
                                        PantsView(pants: pants)
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
    }
}

struct EditAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatarView()
    }
}

struct AccessoriesView: View {
    let accessory: Accessory
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button {
                        print(accessory.name)
                    } label: {
                        Image(accessory.imageURL)
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                }
            }.frame(width: 100, height: 100)

                .background(.white)
                .cornerRadius(10)
        }
    }
}

struct ClothingView: View {
    let clothing: Clothing
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button {
                        print(clothing.name)
                    } label: {
                        Image(clothing.imageURL)
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                }
            }.frame(width: 100, height: 100)

                .background(.white)
                .cornerRadius(10)
        }
    }
}

struct PantsView: View {
    let pants: Pants
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button {
                        print(pants.name)
                    } label: {
                        Image(pants.imageURL)
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                }
            }.frame(width: 100, height: 100)

                .background(.white)
                .cornerRadius(10)
        }
    }
}
