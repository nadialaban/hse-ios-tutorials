//
//  ViewController.swift
//  BlurApp
//
//  Created by Nadia on 29.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    var blurEffectView: UIVisualEffectView?
    
    let imageSet = ["cloud.jpg", "coffee.jpg", "food.jpg", "pmq.jpg", "temple.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let selectedImageIndex = Int(arc4random_uniform(5))
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        print(imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        blurEffectView?.frame = view.bounds
    }


}

