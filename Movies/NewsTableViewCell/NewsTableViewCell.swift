//
//  NewsTableViewCell.swift
//  Movies
//
//  Created by Vaibhav Gawde on 15/05/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTableViewCell"
    @IBOutlet weak var newsImage : UIImageView!
    @IBOutlet weak var newsDescription : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
