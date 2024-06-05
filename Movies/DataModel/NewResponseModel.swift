//
//  NewResponseModel.swift
//  Movies
//
//  Created by Vaibhav Gawde on 15/05/24.
//

import Foundation

struct NewsResponse : Codable {
    let status : String
    let articles: [Article]
}


struct Article : Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}
