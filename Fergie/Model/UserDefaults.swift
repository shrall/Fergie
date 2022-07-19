//
//  UserDefaults.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 21/06/22.
//

import Combine
import Foundation

class UserSettings: ObservableObject {
    @Published var isOnboardingShown: Bool {
        didSet {
            UserDefaults.standard.set(isOnboardingShown, forKey: "isOnboardingShown")
        }
    }

    @Published var coin: Int {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(coin, forKey: "coin")
        }
    }

    @Published var mood: Double {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(mood, forKey: "mood")
        }
    }

    @Published var name: String {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(name, forKey: "name")
        }
    }

    @Published var accessory: String {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(accessory, forKey: "accessory")
        }
    }

    @Published var top: String {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")?.set(top, forKey: "top")
        }
    }

    @Published var bottom: String {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(bottom, forKey: "bottom")
        }
    }

    @Published var ownedTops: [String] {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(ownedTops, forKey: "ownedTops")
        }
    }

    @Published var ownedBottoms: [String] {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(ownedBottoms, forKey: "ownedBottoms")
        }
    }

    @Published var ownedAccessories: [String] {
        didSet {
            UserDefaults(suiteName: "group.com.fergie")!.set(ownedAccessories, forKey: "ownedAccessories")
        }
    }

    init() {
        self.coin = UserDefaults(suiteName: "group.com.fergie")!.integer(forKey: "coin")
        self.mood = UserDefaults(suiteName: "group.com.fergie")!.double(forKey: "mood")
        self.name = UserDefaults(suiteName: "group.com.fergie")!.string(forKey: "name") ?? ""
        self.accessory = UserDefaults(suiteName: "group.com.fergie")!.string(forKey: "accessory") ?? ""
        self.top = UserDefaults(suiteName: "group.com.fergie")!.string(forKey: "top") ?? ""
        self.bottom = UserDefaults(suiteName: "group.com.fergie")!.string(forKey: "bottom") ?? ""
        self.ownedTops = UserDefaults(suiteName: "group.com.fergie")!.stringArray(forKey: "ownedTops") ?? []
        self.ownedBottoms = UserDefaults(suiteName: "group.com.fergie")!.stringArray(forKey: "ownedBottoms") ?? []
        self.ownedAccessories = UserDefaults(suiteName: "group.com.fergie")?.stringArray(forKey: "ownedAccessories") ?? []
    }
}
