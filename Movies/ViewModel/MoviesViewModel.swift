//
//  PopularMoviesVM.swift
//  Movies
//
//  Created by Vaibhav Gawde on 23/05/24.
//

import Foundation


enum MovieType: String {
    case popular = "popular?api_key=c579a58a1a363e67da8e530772e91459"
    case nowPlaying = "now_playing?api_key=c579a58a1a363e67da8e530772e91459"
    case topRated = "top_rated?api_key=c579a58a1a363e67da8e530772e91459"
    case upcoming = "upcoming?api_key=c579a58a1a363e67da8e530772e91459"
}

class MoviesViewModel  {

    var events : ((_ events: Events, MovieType, CommonMovieModel? ) -> Void)?
    
    func fetchPopularMovies(movieType : MovieType){
        APIManager.shared.moviesApiCall(movieType: movieType.rawValue, modelType: CommonMovieModel.self) { response in
            
            self.events?(.stopLoading, movieType, nil)
            
            switch response {
            case .success(let responseData) :
            
                self.events?(.success, movieType, responseData)
                break
            case .failure(let error):
                self.events?(.error(error: error), movieType, nil)
                print(error)
                break
                
            }
        }
    }
    
    
    
}
