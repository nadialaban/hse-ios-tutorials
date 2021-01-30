//
//  SliderViewController.swift
//  ShowCase
//
//  Created by Nadia on 10.01.2021.
//

import UIKit

class SliderViewController: UIViewController, UITextFieldDelegate {
    
    var redColor:CGFloat = 0
    var greenColor:CGFloat = 0
    var blueColor:CGFloat = 0
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValue: UITextField!
    @IBOutlet weak var greenValue: UITextField!
    @IBOutlet weak var blueValue: UITextField!
    
    @IBAction func changeRed(_ sender: Any) {
        redColor = CGFloat(redSlider.value)
        redValue.text = String(format: "%.0f",Float(redColor*255.0))
        updateColor()
    }
    
    @IBAction func changetextRed(_ sender: Any) {
        let val = (redValue.text! as NSString).floatValue
        if val > 255 {
            redSlider.value = 1
        } else if val < 0 {
            redSlider.value = 0
        } else {
            redSlider.value = val / 255.0
        }
        changeRed(sender)
    }
    
    @IBAction func changeGreen(_ sender: Any) {
        greenColor = CGFloat(greenSlider.value)
        greenValue.text = String(format: "%.0f",Float(greenColor*255.0))
        updateColor()
    }
    
    @IBAction func changetextGreen(_ sender: Any) {
        let val = (greenValue.text! as NSString).floatValue
        if val > 255 {
            greenSlider.value = 1
        } else if val < 0 {
            greenSlider.value = 0
        } else {
            greenSlider.value = val / 255.0
        }
        changeGreen(sender)
    }
    
    @IBAction func changeBlue(_ sender: Any) {
        blueColor = CGFloat(blueSlider.value)
        blueValue.text = String(format: "%.0f",Float(blueColor*255.0))
        updateColor()
    }
    
    @IBAction func changetextBlue(_ sender: Any) {
        let val = (blueValue.text! as NSString).floatValue
        if val > 255 {
            blueSlider.value = 1
        } else if val < 0 {
            blueSlider.value = 0
        } else {
            blueSlider.value = val / 255.0
        }
        changeBlue(sender)
    }
    
    func updateColor() {
       self.view.backgroundColor =
            UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValue.delegate = self
        greenValue.delegate = self
        blueValue.delegate = self

        updateColor()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
    return true
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
