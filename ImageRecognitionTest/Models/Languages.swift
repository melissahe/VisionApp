//
//  Languages.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import Foundation

class Languages {
    static var allLanguages = ["test1", "test2", "test3"]
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


