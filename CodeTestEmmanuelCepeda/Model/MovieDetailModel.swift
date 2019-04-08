//
//  MovieDetailModel.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/7/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let runtime : Int?
    let videos :  Videos?
}

struct Videos: Decodable {
    let results: [result]?
}

struct result: Decodable {
    let key : String
    let name : String
}
