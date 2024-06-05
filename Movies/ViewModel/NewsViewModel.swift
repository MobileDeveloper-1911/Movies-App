//
//  NewsViewModel.swift
//  Movies
//
//  Created by Vaibhav Gawde on 15/05/24.
//

import Foundation

final class NewsViewModel {
    
    var news : NewsResponse?
    var events : ((_ events: Events) -> Void)?
    
    func getNews(){
//        APIManager.shared.apiCall(modelType: NewsResponse.self) { response in
//
//            self.events?(.stopLoading)
//
//            switch response {
//
//            case .success(let responseData):
//                self.news = responseData
//                print(responseData)
//                self.events?(.success)
//                break
//
//            case .failure(let error):
//                self.events?(.error(error: error))
//                print(error)
//                break
//            }
//        }
    }
    
}

