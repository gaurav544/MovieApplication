//
//  MoviesRequestManager.swift
//  ProgrammingExercise
//
//  Created by Gaurav Arora on 9/28/22.
//

// MARK: Imports
import Foundation
import UIKit

class MoviesRequestManager: MovieRequestManagerProtocol {
    var imageUrlString: String?
    init(){}
    
    // MARK: API calls
    static func getMovieList(query: String, currentPage: Int, completion: @escaping (MovieList?, Error?) -> ()) {
        let urlString = Services.fetchURL(for: ServiceName.getMovieList, query: query)
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 30
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movieList = try decoder.decode(MovieList.self, from: data)
                        completion(movieList, nil)
                    } catch let error {
                        print(error)
                        completion(nil, error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    static func fetchMoviePoster(posterPath: String, completion: @escaping (UIImage?) -> ()) {
        let urlString = Services.fetchURL(for: ServiceName.fetchMoviePoster, posterPath: posterPath)
        if let imageFromCache = ImageCache.shared.getImageCache().object(forKey: urlString as AnyObject) {
            completion(imageFromCache)
            return
        }
        if let url = URL(string: urlString) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data, let image = UIImage(data: data) {
                  ImageCache.shared.imageCache.setObject(image, forKey: urlString as AnyObject)
                  completion(image)
                  return
              }
               completion(nil)
           }.resume()
        }
    }
}
