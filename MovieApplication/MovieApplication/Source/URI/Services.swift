//
//  Services.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/28/22.
//

// MARK: Imports
import Foundation

public class Services {
    // MARK: Class Variables
    static let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    
    // MARK: Private Methods
    private static func url(_ servicName: ServiceName) -> String {
        switch servicName {
        case .getMovieList:
            return "https://api.themoviedb.org/3/search/movie?api_key={apiKey}&language=en-US&query={query}&page={page}&include_adult=false"
        case .fetchMoviePoster:
            return "https://image.tmdb.org/t/p/original/{poster_path}"
        }
    }
    
    // MARK: Public Methods
    public static func fetchURL(for serviceName: ServiceName, query: String? = nil, currentPage: Int? = 1, posterPath: String? = nil) -> String {
        var urlString = ""
        switch serviceName {
        case .getMovieList:
            urlString = url(.getMovieList)
            let query = query?.replacingOccurrences(of: " ", with: "%20")
            urlString = urlString.replacingOccurrences(of: "{apiKey}", with: apiKey)
            urlString = urlString.replacingOccurrences(of: "{page}", with: String(currentPage ?? 1))
            urlString = urlString.replacingOccurrences(of: "{query}", with: query ?? "")
        case .fetchMoviePoster:
            urlString = url(.fetchMoviePoster)
            urlString = urlString.replacingOccurrences(of: "/{poster_path}", with: posterPath ?? "")
        }
        return urlString
    }
}

// MARK: Public Enums
public enum ServiceName {
    case getMovieList
    case fetchMoviePoster
}
