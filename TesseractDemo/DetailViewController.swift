//
//  DetailViewController.swift
//  OCRDemo
//
//  Created by Adrian Bolinger on 12/12/16.
//  Copyright © 2016 Adrian Bolinger. All rights reserved.
//

import UIKit
import TesseractOCR

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var labelString: String?
    var imageToScan: UIImage?
    
    /// This enum is used for Tesseract's initializer
    
    enum OCRLanguage: String {
        case english = "eng"
        case french = "fra"
    }

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelString
        configureImageView()
        if let imageToScan = imageToScan {
            scanImage(imageToScan)
        }

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Configuration Methods
    func configureImageView() {
        imageView.image = imageToScan
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - OCR Methods
    func scanImage(_ image: UIImage) {
        guard imageToScan != nil else {
            return
        }
        
        // Do the work on the background queue so you don't lock up the UI
        let backgroundQueue = DispatchQueue(label: "com.app.queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        
        backgroundQueue.async {
            // FIXME: At a later date, you'll need to update
            if let tesseract = G8Tesseract(language: OCRLanguage.english.rawValue) {
                tesseract.engineMode = .tesseractCubeCombined
                tesseract.pageSegmentationMode = .auto
                tesseract.delegate = self
                tesseract.image = self.imageToScan!.g8_grayScale()
                tesseract.recognize()
                
                DispatchQueue.main.async {
                    self.textView.text = tesseract.recognizedText
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: G8TesseractDelegate {
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Progress is \(tesseract.progress)")
    }
}
