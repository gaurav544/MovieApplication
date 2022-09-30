//
//  MovieRequestManagerProtocol.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/30/22.
//

import Foundation
import UIKit

protocol MovieRequestManagerProtocol {
    static func getMovieList(query: String, currentPage: Int, completion: @escaping (MovieList?, Error?) -> ())
    static func fetchMoviePoster(posterPath: String, completion: @escaping (UIImage?) -> ())
}
