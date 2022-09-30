//
//  MovieList.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/28/22.
//

import Foundation

struct MovieList: Codable {
    // MARK: Variables
    var page: Int?
    var results: [Result]?
    var totalResults: Int?
    var totalPages: Int?
}
