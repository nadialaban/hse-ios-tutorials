//
//  ViewController.swift
//  ShowMe
//
//  Created by Nadia on 05.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textToSendField: UITextField!
    
    @IBAction func showMe(_ sender: Any) {
        NSLog("User Wrote: %@", textToSendField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let messageController = segue.destination as! MessageViewController;
        messageController.messageData = textToSendField.text
    }

}

