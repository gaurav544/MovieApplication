//
//  MovieSearchViewController.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/28/22.
//

// MARK: Imports
import UIKit

class MovieSearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
    
    // MARK: Variables
    private var currentPage = 0
    private var fetchingResults = false
    private var filteredMovies: MovieList?
    private var selectedMovie: Result?
    
    // MARK: Outlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAppearance()
        searchBar.delegate = self
    }
    
    // MARK: Segue Delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Identifier.movieDetailSegue) {
            let movieDetailViewController = segue.destination as? MovieDetailViewController
            if let indexPath = tableView.indexPath(for: sender as? UITableViewCell ?? UITableViewCell()) {
                selectedMovie = filteredMovies?.results?[indexPath.row]
            }
            movieDetailViewController?.setup(with: selectedMovie)
        }
    }
    
    // MARK: Touch Events
    @IBAction func searchMovies(_ sender: Any) {
        searchBar.endEditing(true)
        self.filteredMovies = nil
        getMovieList(searchText: self.searchBar.searchTextField.text)
    }
    
    // MARK: SearchBar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    // MARK: TableView DataSource and Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieCell, for: indexPath) as! MovieTableViewCell
        
        if indexPath.row == (filteredMovies?.results?.count ?? 0) - 1 && currentPage <= filteredMovies?.totalResults ?? 0 {
            getMovieList(searchText: self.searchBar.searchTextField.text)
        }
        
        if let movieDetail = filteredMovies?.results?[indexPath.row] {
            cell.movieTitle.text = movieDetail.title
            cell.releaseDate.text = (movieDetail.releaseDate ?? "").formatDateString(to: Constants.displayDateFormat1)
            if let voteAverage = movieDetail.voteAverage {
                let formatter = voteAverage > 0 ? voteAverage.formattedAmount : Localizations.noRatingText
                cell.rating.text = formatter
            } else {
                cell.rating.text = Localizations.noRatingText
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies?.results?.count ?? 0
    }
    
    // MARK: Private Methods
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.navigationBarColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    // MARK: Data Manipulation
    private func getMovieList(searchText: String?) {
        guard !fetchingResults else  {
            return
        }
        // One call at a time
        fetchingResults = true
        
        activityIndicatorView.isHidden = false
        self.currentPage += 1
        MoviesRequestManager.getMovieList(query: searchText ?? "", currentPage: currentPage) { [weak self] movieList, error in
            guard let self = self else { return }
            self.fetchingResults = false
            DispatchQueue.main.async {
                self.activityIndicatorView.isHidden = true
            }
            guard let movieList = movieList else {
                if let error = error {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: Localizations.OkTitle, style: UIAlertAction.Style.default, handler: { _ in
                            return
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                return
            }
            if self.filteredMovies?.results == nil {
                self.filteredMovies?.results = []
                self.filteredMovies = movieList
            } else {
                self.filteredMovies?.results! += movieList.results!
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.activityIndicatorView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
}

