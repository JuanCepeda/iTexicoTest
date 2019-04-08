//
//  Movie.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/5/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    let page : Int
    let total_results : Int
    let total_pages : Int
    let results : [Movie]
}

struct Movie: Decodable {
    let genre_ids : [Int]
    let vote_count : Int
    let id : Int
    let video : Bool
    let vote_average : Float
    let title : String
    let popularity : Float
    let poster_path : String
    let original_language : String
    let original_title : String
    let backdrop_path : String
    let adult : Bool
    let overview : String
    let release_date : String
    var movieImageStr : String?
    var favorite: Bool? = false
}
