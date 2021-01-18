//
//  ComposeViewController.swift
//  SocialApp
//
//  Created by Nadia on 16.01.2021.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissView(_ sender: Any) {
    }
    
    @IBAction func postToTwitter(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
