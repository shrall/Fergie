//
//  AppGroup.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 11/07/22.
//

import Foundation

public enum AppGroup: String {
  case facts = "group.com.fergie"

  public var containerURL: URL {
    switch self {
    case .facts:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
