//
//  MoviesCollectionCell.swift
//  Movies
//
//  Created by Vaibhav Gawde on 25/05/24.
//

import UIKit

class MoviesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var moviesImage : UIImageView!   
    @IBOutlet weak var parentView: UIView!
    
    static let reusableIdentifier = "MoviesCollectionCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MoviesCollectionCell", bundle: nil)
    }

}
