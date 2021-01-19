//
//  TripCollectionViewCell.swift
//  CarouselApp
//
//  Created by Nadia on 19.01.2021.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var totalDaysLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var delegate:TripCollectionCellDelegate?
    
    var isLiked:Bool = false {
        didSet {
            if isLiked {
                //UIImage(systemName: "")
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.didLikeButtonPressed(cell: self)
    }
    
}

protocol TripCollectionCellDelegate {
    func didLikeButtonPressed(cell: TripCollectionViewCell)
}
