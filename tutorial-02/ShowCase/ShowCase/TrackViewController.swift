//
//  TrackViewController.swift
//  ShowCase
//
//  Created by Nadia on 10.01.2021.
//

import UIKit
import CoreLocation

class TrackViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    @IBOutlet weak var locationText: UITextView!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    @IBAction func changeToggle(_ sender: Any) {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.distanceFilter = 10.0
            locationManager.desiredAccuracy =
            kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        }
        
        if toggleSwitch.isOn {
            locationManager.startUpdatingLocation()
            locationText.text = locationManager.description
        }
        else {
            locationManager.stopUpdatingLocation()
            locationText.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.endIndex-1] as CLLocation
        self.locationText.text = location.description
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { locationText.text = "failed with error \(error.localizedDescription) "
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
