//
//  ViewController.swift
//  ImageRecognitionTest
//
//  Created by Lisa J on 4/20/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class CameraViewController: UIViewController , AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let cameraView = CameraView()
    let baseLanguageVC = BaseLanguageViewController()
    let targetLanguageVC = TargetLanguageViewController()
    public var currentBaseLanguage = ""
    public var currentTargetLanguage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        view.addSubview(cameraView)
        targetLanguageVC.targetLanguageDelegate = self
        baseLanguageVC.baseLanguageDelegate = self
        cameraView.button.addTarget(self, action: #selector(translate), for: .touchUpInside)
        cameraView.baseLanguageButton.addTarget(self, action: #selector(baseLanguageButtonAction), for: .touchUpInside)
        cameraView.targetLanguageButton.addTarget(self, action: #selector(targetLanguageButtonAction), for: .touchUpInside)
        if let savedBaseLanguage = UserDefaultsHelper.manager.getBaseLanguage() {
            currentBaseLanguage = savedBaseLanguage
        }
        if let savedTargetLanguage = UserDefaultsHelper.manager.getTargetLanguage() {
            currentTargetLanguage = savedTargetLanguage
        }
    }
    
    var player: AVAudioPlayer?
    
    func playSound(forText text: String, withLanguage language: String) {
        TextToSpeechAPI.manager.getSpeechData(forText: text, inLanguage: language) {[weak self] (data, error) in
            self!.cameraView.stopActivityImageView()
            if let data = data, let strongSelf = self {
                do {
                    strongSelf.player = try AVAudioPlayer(data: data)
                    strongSelf.player?.play()
                } catch {
                    // couldn't load file :( do some error handling
                    print(error)
                }
                
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        // search for available capture devices
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        
        // setup capture device, add input to our capture session
        do {
            if let captureDevice = availableDevices.first {
                let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
                captureSession.addInput(captureDeviceInput)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        // setup output, add output to our capture session
        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(captureOutput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    // called everytime a frame is captured
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {return}
        
        let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
            
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            guard let Observation = results.first else { return }
            
            DispatchQueue.main.async(execute: {
                self.cameraView.untranslatedLabel.text = "\(Observation.identifier)"
            })
        }
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // executes request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    @objc func translate() {
        cameraView.spinActivityImageView()
        print(cameraView.untranslatedLabel.text ?? "??")
        let text = cameraView.untranslatedLabel.text ?? ""
        Translation.manager.translateLang(text: text, targetLanguage: currentTargetLanguage) {[weak self] (translatedText, error) in
            if let translatedText = translatedText {
                self!.cameraView.translatedLabel.text = translatedText
                self!.playSound(forText: translatedText, withLanguage: self!.currentTargetLanguage)
            } else if let error = error {
                //error handling needed
                print(error)
            }
        }
    }
    
    @objc func baseLanguageButtonAction() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        baseLanguageVC.modalTransitionStyle = .crossDissolve
        baseLanguageVC.modalPresentationStyle = .overCurrentContext
        present(baseLanguageVC, animated: false, completion: nil)
    }
    
    @objc func targetLanguageButtonAction() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        targetLanguageVC.modalTransitionStyle = .crossDissolve
        targetLanguageVC.modalPresentationStyle = .overCurrentContext
        present(targetLanguageVC, animated: false, completion: nil)
    }
    
}

extension CameraViewController: TargetLanguageDelegate {
    func passSelectedTargetLanguageToCameraVC(selectedLanguage: String) {
        self.currentTargetLanguage = selectedLanguage
        let stringArray = Array(selectedLanguage).map{String($0)}
        let stringSeparatedByBreaks = stringArray.joined(separator: "\n")
        cameraView.baseLanguageButton.setTitle(stringSeparatedByBreaks, for: .normal)
    }
}
extension CameraViewController: BaseLanguageDelegate {
    func passSelectedBaseLanguageToCameraVC(selectedLanguage: String) {
        self.currentBaseLanguage = selectedLanguage
    }
}





