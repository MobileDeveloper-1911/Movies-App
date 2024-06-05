//
//  TvSeriesViewModel.swift
//  Movies
//
//  Created by Vaibhav Gawde on 26/05/24.
//

import Foundation


enum SeriesType: String {
    case airingToday = "airing_today"
    case onTheAir = "on_the_air"
    case popular = "popular"
    case topRated = "top_rated"
}

class TvSeriesViewModal {
    
    var tvSeriesResponse : CommonMovieModel?
    var events : ((_ events : Events,SeriesType, CommonMovieModel?) -> Void)?
    
    
    func fetchTvSeries(seriesType : SeriesType){
        APIManager.shared.tvSeriesApiCall(seriesType: seriesType.rawValue, modelType: CommonMovieModel.self) { response in
            
            self.events?(.loading,seriesType,nil)
            
            switch response {
                case .success(let responseData) :
                    //print(responseData)
                    self.events?(.success,seriesType,responseData)
                    break
                    
                case .failure(let error):
                    self.events?(.error(error: error),seriesType,nil)
                    break
            }
            
        }
    }
    
}
