//
//  APIManager.swift
//  Movies
//
//  Created by Vaibhav Gawde on 15/05/24.
//

import Foundation

enum APIStatus : Error{
    case Success
    case Failure
    case FailResponseCode
    case InvalidURL
}

final class APIManager {
    
    static let shared = APIManager()
    
    
    private init(){}
    
    func moviesApiCall<T : Codable>(movieType : String,modelType : T.Type,completion : @escaping (Result<T, APIStatus>) -> Void){
        
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(movieType)")
        print(url)
        
        
        guard let url = url else {
            completion(.failure(.InvalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.Failure))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.FailResponseCode))
                return
            }
            
            do{
                let news = try JSONDecoder().decode(modelType, from: data)
                completion(.success(news))
            }catch{
                completion(.failure(.Failure))
            }
            
        }
        
        task.resume()
    
    }
    
    func tvSeriesApiCall<T : Codable>(seriesType : String,modelType : T.Type,completion : @escaping (Result<T, APIStatus>) -> Void){
        
        let url = URL(string:"https://api.themoviedb.org/3/tv/\(seriesType)?api_key=c579a58a1a363e67da8e530772e91459")
        
        
        print(url)
        guard let url = url else {
            completion(.failure(.InvalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.Failure))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.FailResponseCode))
                return
            }
            
            do{
                let news = try JSONDecoder().decode(modelType, from: data)
                completion(.success(news))
            }catch{
                completion(.failure(.Failure))
            }
            
        }
        
        task.resume()
    
    }
    
    
    
}
