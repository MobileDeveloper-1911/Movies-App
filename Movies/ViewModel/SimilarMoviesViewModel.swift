//
//  File.swift
//  Movies
//
//  Created by Vaibhav Gawde on 05/06/24.
//

import Foundation

class SimilarMovies {
    
    var events : ( (_ events : Events) -> Void )?
    var similarMoviesData : CommonMovieModel?
    
    
    func getSimilarMovies(movieID : Int) {
        
        APIManager.shared.moviesApiCall(movieType: "\(movieID)/similar?api_key=c579a58a1a363e67da8e530772e91459", modelType: CommonMovieModel.self) { response in
            
            self.events?(.loading)
            
            switch response {
                
            case .success(let responseData) :
                self.similarMoviesData = responseData
                self.events?(.success)
                break
                
            case .failure(let error) :
                print(error)
                self.events?(.error(error: error))
                
            }
            
    
        }
        
        
    }
}
