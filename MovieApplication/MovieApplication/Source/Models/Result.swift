//
//  Result.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/28/22.
//

import Foundation

struct Result: Codable, Hashable {
    // MARK: Variables
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var timeStamp: Date?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
}
