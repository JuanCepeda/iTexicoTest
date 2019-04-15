//
//  File.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/4/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import Foundation
import UIKit


// MARK: Web Service to get all movies
class WebServices: NSObject {
    
    class func getMovies(isTopRated: Bool,_ completionHandler:@escaping ( _ Array: [Movie]?, _ err: Error? ) -> Void) {
        
        let order = isTopRated ? Constants.url.topRated : Constants.url.popular
        
        let urlString = Constants.url.baseUrl + order + Constants.url.APIKey
        guard let url = URL(string: urlString)else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data)
                let moviesArr = movies.results
                
                completionHandler(moviesArr,nil)
            }catch let jsonError {
                print(jsonError)
                completionHandler(nil,jsonError)
            }
            }.resume()
    }
    
    class func getMovieDetail(id: String,_ completionHandler:@escaping ( _ Array: MovieDetail?, _ err: Error? ) -> Void) {
        
        let urlString = Constants.url.baseUrl + id + Constants.url.api_key + Constants.url.APIKey + Constants.url.append_to_response_videos
        guard let url = URL(string: urlString)else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let movie = try JSONDecoder().decode(MovieDetail.self, from: data)
                
                completionHandler(movie,nil)
            }catch let jsonError {
                print(jsonError)
                completionHandler(nil,jsonError)
            }
            }.resume()
    }
}
