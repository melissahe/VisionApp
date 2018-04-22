//
//  Languages.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import Foundation

class Languages {
    static var allLanguages = ["Arabic", "Bulgarian", "Catalan", "Chinese", "Croatian", "Czech", "Danish", "Dutch", "German", "Greek", "English", "Finnish", "French", "Hebrew", "Hindi", "Hungarian", "Indonesian", "Italy", "Japan", "Korean", "Malay", "Norwegian", "Polish", "Portugese", "Romanian", "Slovak", "Spanish", "Swedish", "Tamil", "Thai", "Turkish", "Vietnamese"]
    static var currentBaseLanguage = ""  {
        didSet {
            UserDefaultsHelper.manager.setBaseLanguage(to: currentBaseLanguage)
        }
    }
    static var currentTargetLanguage = "" {
        didSet {
            UserDefaultsHelper.manager.setTargetLangauge(to: currentTargetLanguage)
        }
    }
}


