//
//  Constants.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/4/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import Foundation
import ViewAnimator

struct Constants {
    
    struct url {
        static let baseUrl = "https://api.themoviedb.org/3/movie/"
        static let topRated = "top_rated?api_key"
        static let popular = "popular?api_key"
        static let APIKey = "=1ea7db6967a31caedb00ef485db72bf6"
        static let movieImageBaseUrlw780 = "https://image.tmdb.org/t/p/w780"
        static let movieImageBaseUrlOriginal = "https://image.tmdb.org/t/p/original"
        static let youtubeLink = "https://www.youtube.com/watch?v="
        static let api_key = "?api_key"
        static let append_to_response_videos = "&append_to_response=videos"
    }
    
    struct strings {
        static let youTubeNavegationBarTitle = "Youtube"
        static let borderWidth: CGFloat = 1.0
        static let imageStar: String = "star"
        static let imageStarGray : String = "star-gray"
        static let navegationBarTitle : String = "Movie Detail"
        static let cellId = "CellDetail"
        static let showYoutubeSegue = "SegueYoutube"
        static let ShowDetail: String = "showDetail"
        static let placeHolder: String = "placeholder.jpg"
        static let navegationTitleRated : String = "Higher Audience"
        static let navegationTitlePopular: String = "Popular"
        static let reuseIdentifier: String = "Cell"
    }
    
}
