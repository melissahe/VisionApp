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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        view.addSubview(cameraView)
        cameraView.button.addTarget(self, action: #selector(translate), for: .touchUpInside)
        cameraView.baseLanguageButton.addTarget(self, action: #selector(baseLanguageButtonAction), for: .touchUpInside)
        cameraView.targetLanguageButton.addTarget(self, action: #selector(targetLanguageButtonAction), for: .touchUpInside)
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
                self.cameraView.label.text = "\(Observation.identifier)"
            })
        }
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // executes request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    @objc func translate() {
        print(cameraView.label.text ?? "??")
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


