//
//  UserDefaultsManager.swift
//
//  
//

import Foundation

enum UserDefaultsType: String, CaseIterable {
    case isLogedIn
    case email
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    func saveDataString(value: String, key: UserDefaultsType) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getDataString(key: UserDefaultsType) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    func saveDataBool(value: Bool, key: UserDefaultsType) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getBool(key: UserDefaultsType) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func removeAllData() {
        for key in UserDefaultsType.allCases {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
