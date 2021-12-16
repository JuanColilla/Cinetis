//
//  ProfileViewModel.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 20/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation

class ProfileViewModel {
    struct Constants {
        var alertProfileTitleCancelButton = "alertProfileTitle".localized()
        var alertProfileMessage = "alertProfileMessage".localized()
        var alertProfileTitleSaveButton = "alertProfileTitleSave".localized()
        var alertProfileMessageSaveButton = "alertProfileMessageSave".localized()
        var alertProfileActionOK = "profileOkAlert".localized()
        var alertProfileActionCancel = "alertProfileActionCancel".localized()
        var alertGoBackButtonTitle = "alertGoBackButtonTitle".localized()
        var alertGoBackButtonMessage = "alertGoBackButtonMessage".localized()
        var deleteDataOption = "deleteDataOption".localized()
        var buttonCancelText = "buttonCancelText".localized()
        var settingsTitle = "settingsTitle".localized()
        var doesUserExists = "isSaved"
        var nameKey = "name"
        var departmentKey = "department"
        var mailKey = "mail"
        var telephoneKey = "telephone"
        var aboutMeKey = "aboutMe"
    }
    
    let constants = Constants()
    
    let userDefault = UserDefaultManager.shared
    
    /// This function checks if the key it has been given exists in the User Defaults.
    /// - Parameter key: this parameter is a String to be able to find what we are searching for in the User Defaults.
    /// - Returns: returns a Bool indicating if the key was found or not.
    func doesUserExists(_ key: String) -> Bool {
        return userDefault.checkKeyInUserExists(forKeyName: key)
    }
    
    /// This function check's what string has the key that it's passed in the UserDefaults.
    /// - Parameter key: this parameter is a String (key) to be able to find another String that it's associated to.
    /// - Returns: returns the String that it finds with the key.
    func getString(_ key: String) -> String {
        return userDefault.getString(key: key)
    }
    
    /// This function saves a String value with it's correspondent key in the User Defaults.
    /// - Parameters:
    ///   - value: this parameter is the String you want to save in the User Defaults.
    ///   - forKey: this parameter is the key associated with the value to be able to find it after.
    func saveString(_ value: String, _ forKey: String) {
        userDefault.saveString(value, forKey: forKey)
    }
    
    /// This function saves a state with it's key in the User Defaults.
    /// - Parameters:
    ///   - value: this parameter is a Bool that indicated the state of a certain object or action.
    ///   - forKey: this parameter is the key that will be saved with the value.
    func saveBool(_ value: Bool, _ forKey: String) {
        userDefault.saveBool(value, forKey: forKey)
    }
    
    /// This function tells the User Default to erase everything it has saved with the key passen.
    /// - Parameter key: this parameter is a String that contains the key of the value we want to erase from User Defaults.
    func resetUserDefaults(_ key: String) {
        userDefault.resetUserDefaults(key: key)
    }
    
}
