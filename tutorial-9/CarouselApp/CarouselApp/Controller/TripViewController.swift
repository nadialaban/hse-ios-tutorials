//
//  TripViewController.swift
//  CarouselApp
//
//  Created by Nadia on 19.01.2021.
//

import UIKit

class TripViewController: UIViewController, UICollectionViewDelegate,
                          UICollectionViewDataSource, TripCollectionCellDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var trips = [
        Trip(tripId: "Paris001", city: "Paris",
             country: "France", featuredImage: UIImage(named: "paris.jpg"),
             price: 2000, totalDays: 5, isLiked: false),
        Trip(tripId: "Rome001", city: "Rome",
             country: "Italy", featuredImage: UIImage(named: "rome.jpg"),
             price: 800, totalDays: 3, isLiked: false),
        Trip(tripId: "Istanbul001", city: "Istanbul",
             country: "Turkey", featuredImage: UIImage(named: "Istanbul.jpg"),
             price: 2200, totalDays: 10, isLiked:false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = UIColor.clear
        
        if UIScreen.main.bounds.size.height == 568.0 {
            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSize(width: 250.0, height: 330.0)
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TripCollectionViewCell
        // Configure the cell
        cell.cityLabel.text = trips[indexPath.row].city
        cell.countryLabel.text = trips[indexPath.row].country
        cell.imageView.image = trips[indexPath.row].featuredImage
        cell.priceLabel.text = "$\(String(trips[indexPath.row].price))"
        cell.totalDaysLabel.text = "\(trips[indexPath.row].totalDays) days"
        cell.isLiked = trips[indexPath.row].isLiked
        // Apply round corner
        cell.layer.cornerRadius = 4.0
        cell.delegate = self
        
        return cell
    }

    func didLikeButtonPressed(cell: TripCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            trips[indexPath.row].isLiked = !trips[indexPath.row].isLiked
            cell.isLiked = trips[indexPath.row].isLiked
            
            //            trips[indexPath.row].isLiked = trips[indexPath.row].isLiked ? false : Bool(cell.isLiked = trips[indexPath.row].isLiked)
        }

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
