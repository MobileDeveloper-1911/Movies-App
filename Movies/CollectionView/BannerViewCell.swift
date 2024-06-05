//
//  BannerViewCell.swift
//  Movies
//
//  Created by Vaibhav Gawde on 25/05/24.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage : UIImageView!
    @IBOutlet weak var parentView : UIView!
    static let reusableIdentifier = "BannerViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BannerViewCell", bundle: nil)
    }

}
