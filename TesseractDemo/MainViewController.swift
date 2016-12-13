//
//  MainViewController.swift
//  OCRDemo
//
//  Created by Adrian Bolinger on 12/12/16.
//  Copyright © 2016 Adrian Bolinger. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    
    // Constructed an enum to minimize typos
    enum TestImage: String {
        case image0 = "image0.jpg"
        case image1 = "image1.jpg"
        case image2 = "image2.jpg"
        case image3 = "image3.jpg"
        case image4 = "image4.jpg"
        case image5 = "image5.jpg"
    }
    
    // create a variable to pass along to the next viewController
    var imageToScan: UIImage? {
        didSet {
            print("imageToScan updated")
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Configuration methods
    func configureButtons() {
        let buttonArray = [buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix]
        
        for button in buttonArray {
            if let buttonTag = button?.tag {
                let filename = String(format: "image%d.jpg", buttonTag)
                let buttonImage = UIImage(named: filename)?.withRenderingMode(.alwaysOriginal)
                button?.setImage(buttonImage, for: .normal)
                button?.imageView?.contentMode = .scaleAspectFit
            }
            button?.layer.cornerRadius = 10.0
            button?.layer.borderWidth = 2.0
            button?.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        // set the image on the currentViewController
        switch sender.tag {
        case 0:
            imageToScan = UIImage(named: TestImage.image0.rawValue)!
        case 1:
            imageToScan = UIImage(named: TestImage.image1.rawValue)!
        case 2:
            imageToScan = UIImage(named: TestImage.image2.rawValue)!
        case 3:
            imageToScan = UIImage(named: TestImage.image3.rawValue)!
        case 4:
            imageToScan = UIImage(named: TestImage.image4.rawValue)!
        case 5:
            imageToScan = UIImage(named: TestImage.image5.rawValue)!
        default:
            return
        }
        
        performSegue(withIdentifier: "detailSegue", sender: sender)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.imageToScan = imageToScan
            switch (sender as! UIButton).tag {
            case 0:
                destinationViewController.labelString = TestImage.image0.rawValue
            case 1:
                destinationViewController.labelString = TestImage.image1.rawValue
            case 2:
                destinationViewController.labelString = TestImage.image2.rawValue
            case 3:
                destinationViewController.labelString = TestImage.image3.rawValue
            case 4:
                destinationViewController.labelString = TestImage.image4.rawValue
            case 5:
                destinationViewController.labelString = TestImage.image5.rawValue
            default:
                break
            }
        }
    }

}
