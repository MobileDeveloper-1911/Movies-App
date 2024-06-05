//
//  SeriesTypeCell.swift
//  Movies
//
//  Created by Vaibhav Gawde on 27/05/24.
//

import UIKit

class SeriesTypeCell: UICollectionViewCell {
    
    @IBOutlet weak var parentView : UIView!
    @IBOutlet weak var seriesTypeLabel : UILabel!
    
    static let reusableIdentifier = "SeriesTypeCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SeriesTypeCell", bundle: nil)
    }

}
