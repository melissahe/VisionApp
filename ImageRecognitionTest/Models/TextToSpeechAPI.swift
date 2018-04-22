//
//  TextToSpeech.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import Foundation

class TextToSpeechAPI {
    private let apiKey = "6f4a3f384615415e8b3386baded89b55"
    private init() {}
    public static let manager = TextToSpeechAPI()
    private let languageDict: [String : (languageCode: String, serviceNameMapping: String)] = [
        "Arabic" : ("ar-EG","Microsoft Server Speech Text to Speech Voice (ar-EG, Hoda)"),
        "Bulgarian" : ("bg-BG", "Microsoft Server Speech Text to Speech Voice (bg-BG, Ivan)"),
        "Catalan" : ("ca-ES", "Microsoft Server Speech Text to Speech Voice (ca-ES, HerenaRUS)"),
        "Chinese" : ("zh-CN", "Microsoft Server Speech Text to Speech Voice (zh-CN, HuihuiRUS)"),
        "Croatian" : ("hr-HR", "Microsoft Server Speech Text to Speech Voice (hr-HR, Matej)"),
        "Czech" : ("cs-CZ", "Microsoft Server Speech Text to Speech Voice (cs-CZ, Jakub)"),
        "Danish" : ("da-DK", "Microsoft Server Speech Text to Speech Voice (da-DK, HelleRUS)"),
        "Dutch" : ("nl-NL", "Microsoft Server Speech Text to Speech Voice (nl-NL, HannaRUS)"),
        "German" : ("de-DE", "Microsoft Server Speech Text to Speech Voice (de-DE, Hedda)"),
        "Greek" : ("el-GR", "Microsoft Server Speech Text to Speech Voice (el-GR, Stefanos)"),
        "English" : ("en-US", "Microsoft Server Speech Text to Speech Voice (en-US, JessaRUS)"),
        "Finnish" : ("fi-FI", "Microsoft Server Speech Text to Speech Voice (fi-FI, HeidiRUS)"),
        "French" : ("fr-FR", "Microsoft Server Speech Text to Speech Voice (fr-FR, Julie, Apollo)"),
        "Hebrew" : ("he-IL", "Microsoft Server Speech Text to Speech Voice (he-IL, Asaf)"),
        "Hindi" : ("hi-IN", "Microsoft Server Speech Text to Speech Voice (hi-IN, Kalpana)"),
        "Hungarian" : ("hu-HU", "Microsoft Server Speech Text to Speech Voice (hu-HU, Szabolcs)"),
        "Indonesian" : ("id-ID", "Microsoft Server Speech Text to Speech Voice (id-ID, Andika)"),
        "Italy" : ("it-IT", "Microsoft Server Speech Text to Speech Voice (it-IT, Cosimo, Apollo)"),
        "Japan" : ("ja-JP", "Microsoft Server Speech Text to Speech Voice (ja-JP, HarukaRUS)"),
        "Korean" : ("ko-KR", "Microsoft Server Speech Text to Speech Voice (ko-KR, HeamiRUS)"),
        "Malay" : ("ms-MY", "Microsoft Server Speech Text to Speech Voice (ms-MY, Rizwan)"),
        "Norwegian" : ("nb-NO", "Microsoft Server Speech Text to Speech Voice (nb-NO, HuldaRUS)"),
        "Polish" : ("pl-PL", "Microsoft Server Speech Text to Speech Voice (pl-PL, PaulinaRUS)"),
        "Portugese" : ("pt-PT", "Microsoft Server Speech Text to Speech Voice (pt-PT, HeliaRUS)"),
        "Romanian" : ("ro-RO", "Microsoft Server Speech Text to Speech Voice (ro-RO, Andrei)"),
        "Slovak" : ("sk-SK", "Microsoft Server Speech Text to Speech Voice (sk-SK, Filip)"),
        "Spanish" : ("es-ES", "Microsoft Server Speech Text to Speech Voice (es-ES, Laura, Apollo)"),
        "Swedish" : ("sv-SE", "Microsoft Server Speech Text to Speech Voice (sv-SE, HedvigRUS)"),
        "Tamil" : ("ta-IN", "Microsoft Server Speech Text to Speech Voice (ta-IN, Valluvar)"),
        "Thai" : ("th-TH", "Microsoft Server Speech Text to Speech Voice (th-TH, Pattara)"),
        "Turkish" : ("tr-TR", "Microsoft Server Speech Text to Speech Voice (tr-TR, SedaRUS)"),
        "Vietnamese" : ("vi-VN", "Microsoft Server Speech Text to Speech Voice (vi-VN, An)")]
    
    private func getAuthToken(completionHandler: @escaping (String?, Error?) -> Void) {
        let urlString = "https://api.cognitive.microsoft.com/sts/v1.0/issueToken"
        guard let url = URL(string: urlString) else {
            completionHandler(nil, AppError.badURL(url: urlString))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: { (data) in
            let string = String(data: data, encoding: .utf8)
            completionHandler(string, nil)
        }, errorHandler: { (error) in
            completionHandler(nil, error)
        })
    }
    //make dictionary to get language code
    public func getSpeechData(forText text: String, inLanguage language: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let urlString = "https://speech.platform.bing.com/synthesize"
        guard let url = URL(string: urlString) else {
            completionHandler(nil, AppError.badURL(url: urlString))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/ssml+xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("audio-16khz-128kbitrate-mono-mp3", forHTTPHeaderField: "X-Microsoft-OutputFormat")
        //get language stuff here
        guard let languageCode = languageDict[language]?.languageCode, let serviceNameMapping = languageDict[language]?.serviceNameMapping else {
            completionHandler(nil, nil)
            print("Error: could not get language")
            return
        }
        let httpBody = """
        <speak version='1.0' xmlns="http://www.w3.org/2001/10/synthesis" xml:lang='\(languageCode)'><voice name='\(serviceNameMapping)'><prosody rate="-20.00%" contour="(20%,+80%) (50%,+0%)" >\(text)</prosody></voice> </speak>
        """.data(using: .utf8)!
        urlRequest.httpBody = httpBody
        getAuthToken { (authToken, error) in
            if let authToken = authToken {
                let authStr = "Bearer \(authToken)"
                urlRequest.addValue(authStr, forHTTPHeaderField: "Authorization")
                NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: { (data) in
                    completionHandler(data, nil)
                }, errorHandler: { (error) in
                    completionHandler(nil, error)
                })
            } else if let error = error {
                completionHandler(nil, error)
            }
        }
    }
}
