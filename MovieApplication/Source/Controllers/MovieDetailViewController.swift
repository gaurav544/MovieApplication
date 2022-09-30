//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/28/22.
//

// MARK: Imports
import Foundation
import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewable {
    
    // MARK: Stubs
    func setup(with movieDetail: Result?) {
        self.movieDetail = movieDetail
    }
    
    // MARK: Variables
    private var movieDetail: Result?
    
    // MARK: Outlets
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitle.text = movieDetail?.title
        let releaseDateValue = (movieDetail?.releaseDate ?? "").formatDateString(to: Constants.displayDateFormat2)
        let releaseDateText = Localizations.releaseDateTextWithValue.replacingOccurrences(of: "{release_date}", with: releaseDateValue)
        releaseDate.text = releaseDateText
        movieDescription.text = movieDetail?.overview
        getMoviePoster(imagePath: movieDetail?.posterPath)
    }
    
    // MARK: Data Manipulation
    private func getMoviePoster(imagePath: String?) {
        MoviesRequestManager.fetchMoviePoster(posterPath: imagePath ?? "") { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let image = image {
                    self.movieImage.image = image
                }
            }
        }
    }
}
