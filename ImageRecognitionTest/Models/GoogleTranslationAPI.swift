//
//  GoogleTranslationAPI.swift
//  ImageRecognitionTest
//
//  Created by C4Q on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let data: DataWrapper
}

struct DataWrapper: Codable {
    let translations: [TranslationWrapper]
}
struct TranslationWrapper: Codable {
    let translatedText: String
}

class Translation {
    static let manager = Translation()
    private init() {}
    public func translateLang(text: String, targetLanguage: String, source: String, callback: @escaping (_ translatedText: String?, _ error: Error?) -> ()) {
        let apiKey = "AIzaSyAcHVPnSW2jo_45RIh6zqp_3EGHJO8y610"
        
        var request = URLRequest(url: URL(string: "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        let jsonRequest = [
            "q": text,
            "source": "en",
            "target": targetLanguage,
            "format": "text"]
        let jsonEncoder = JSONEncoder()
        let json = try! jsonEncoder.encode(jsonRequest)
        request.httpBody = json
        NetworkHelper.manager.performDataTask(with: request, completionHandler: { (data) in
            do {
                let result = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                let text = result.data.translations.first?.translatedText
                callback(text, nil)
            } catch {
                callback(nil, error)
            }
        }, errorHandler: { error in
            callback(nil, error)
        })
    }
}



