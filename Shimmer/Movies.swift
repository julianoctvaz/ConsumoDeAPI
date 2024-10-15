//
//  Movies.swift
//  Shimmer
//
//  Created by Juliano on 14/10/24.
//

import Foundation

struct Movies: Codable { //reponse da api MoviesReponse ou MoviesModel ou MoviesResponseModel
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

//testar so pegar titulo e url

struct Movie: Codable, Hashable {
    let id: String
    let title: String
    let released: String?
    let language: String?
    let country: String?
    let genre: String?
    let plot: String?
    let posterURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case released = "Released"
        case language = "Language"
        case country = "Country"
        case genre = "Genre"
        case plot = "Plot"
        case posterURL = "Poster"

    }
}
