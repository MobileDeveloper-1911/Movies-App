//
//  PopularMovieModel.swift
//  Movies
//
//  Created by Vaibhav Gawde on 23/05/24.
//

import Foundation

struct CommonMovieModel : Codable {
    
    let results : [ResultData]?
}

struct ResultData : Codable{
    
    let id: Int?
    let backdrop_path: String?
    let overview: String?
    let poster_path: String?
    let original_title: String?
    let release_date: String?
    let original_language: String?
    
    
}
