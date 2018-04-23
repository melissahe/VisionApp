//
//  UserDefaults.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import Foundation
struct UserDefaultsHelper {
    static let manager = UserDefaultsHelper()
    private init() {}
    private let baseLanguageKey = "baseLanguageKey"
    private let targetLanguageKey = "targetLanguageKey"
    
    //Get Stuff
    func getBaseLanguage() -> String? {
        return UserDefaults.standard.string(forKey: baseLanguageKey)
    }
    func getTargetLanguage() -> String? {
        return UserDefaults.standard.string(forKey: targetLanguageKey)
    }
    
    //Save Stuff
    func setBaseLanguage(to newZipcode: String) {
        UserDefaults.standard.setValue(newZipcode, forKey: baseLanguageKey)
    }
    func setTargetLangauge(to newZipcode: String) {
        UserDefaults.standard.setValue(newZipcode, forKey: targetLanguageKey)
    }
}
