//
//  UserDefaults.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 21/06/22.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var coin: Int {
        didSet {
            UserDefaults.standard.set(coin, forKey: "coin")
        }
    }
    @Published var mood: Int {
        didSet {
            UserDefaults.standard.set(mood, forKey: "mood")
        }
    }
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    @Published var accessory: String {
        didSet {
            UserDefaults.standard.set(accessory, forKey: "accessory")
        }
    }
    @Published var top: String {
        didSet {
            UserDefaults.standard.set(top, forKey: "top")
        }
    }
    @Published var bottom: String {
        didSet {
            UserDefaults.standard.set(bottom, forKey: "bottom")
        }
    }
    
    init() {
        self.coin = UserDefaults.standard.integer(forKey: "coin")
        self.mood = UserDefaults.standard.integer(forKey: "mood")
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        self.accessory = UserDefaults.standard.string(forKey: "accessory") ?? ""
        self.top = UserDefaults.standard.string(forKey: "top") ?? ""
        self.bottom = UserDefaults.standard.string(forKey: "bottom") ?? ""
    }
}
