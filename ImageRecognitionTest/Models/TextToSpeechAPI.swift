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
        let httpBody = """
        <speak version='1.0' xmlns="http://www.w3.org/2001/10/synthesis" xml:lang='zh-CN'><voice name='Microsoft Server Speech Text to Speech Voice (zh-CN, HuihuiRUS)'><prosody rate="-20.00%" contour="(20%,+80%) (50%,+0%)" >你好</prosody></voice> </speak>
        """.data(using: .utf8)!
//        let json = try! JSONEncoder().encode(httpBody)
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
