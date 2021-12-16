//
//  File.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 19/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation

/// UserDefaultManager is a singleton class that manages the User Defaults functions. It has a property defaults to be able to access via shared to the UserDefaults.standard property.
/// And it has some functions to be able to reset the User Defaults via their key, to check if an object exists inside User Defaults, to save an object, and return a value of a certain object.
class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init(){}
    
    private let defaults = UserDefaults.standard
    
    func resetUserDefaults(key: String) {
        defaults.removeObject(forKey: key)
    }
    
    func checkKeyInUserExists(forKeyName: String) -> Bool {
        return defaults.object(forKey: forKeyName) != nil
    }
    
    func saveString(_ value: String, forKey: String) {
        defaults.set(value, forKey: forKey)
    }
    
    func saveBool(_ value: Bool, forKey: String) {
        defaults.set(value, forKey: forKey)
    }
    
    func getString(key: String) -> String {
        return defaults.string(forKey: key) ?? ""
    }
    
    func getBoolForKey(key: String) -> Bool {
        if let value = defaults.string(forKey: key) {
            return Bool(value) ?? true
        }
        return false
    }
}
