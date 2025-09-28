//
//  NetworkingHelper.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import Foundation

enum AppURL: String {
    case dogBase = "https://api.thedogapi.com/v1"
    case catBase = "https://api.thecatapi.com/v1"
}

class NetworkingHelper {
    let header: [String: Any] = [:]
    
}

class Constants {
    static let dogBaseURL: AppURL = .dogBase
    static let dogApiKey = "live_mi2mnhuro1DJgEDv3pRPdnwbf5iyyce6CgVACVy6iO0I3lxcYXApJW9C2cwtqDco"
    static let catApiKey = "live_7YRvKzuq9zKNqXFvFhgh00oMZTGbgMK4JuTxTgVclM7hdUQm4hjxHsTDskWLcegT"
}
