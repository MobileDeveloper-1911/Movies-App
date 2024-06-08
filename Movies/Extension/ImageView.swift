//
//  ImageView.swift
//  Movies
//
//  Created by Vaibhav Gawde on 25/05/24.
//

import Foundation
import Kingfisher
import UIKit


extension UIImageView {
    
    func setImage(with urlString: String){

        guard let url = URL.init(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {

            return
        }

        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)

    }
}
