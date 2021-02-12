//
//  ViewController.swift
//  LocalizeMe
//
//  Created by Nadia on 12.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var localeLabel : UILabel!
    @IBOutlet var flagImageView : UIImageView!
    @IBOutlet var labels : [UILabel]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let locale = NSLocale.current
        let currentLangID = NSLocale.preferredLanguages[0]
//        let displayLang = locale.objectForKey(NSLocaleLanguageCode, value: currentLangID)
//        let capitalized = displayLang?.capitalizedStringWithLocale(locale)
        localeLabel.text = currentLangID //capitalized
        labels[0].text = NSLocalizedString("LABEL_ONE", comment: "The number 1")
        labels[1].text = NSLocalizedString("LABEL_TWO", comment: "The number 2")
        labels[2].text = NSLocalizedString("LABEL_THREE", comment: "The number 3")
        labels[3].text = NSLocalizedString("LABEL_FOUR", comment: "The number 4")
        labels[4].text = NSLocalizedString("LABEL_FIVE", comment: "The number 5")
        let flagFile = NSLocalizedString("FLAG_FILE", comment: "Name of the flag")
        flagImageView.image = UIImage(named: flagFile)
    }


}

