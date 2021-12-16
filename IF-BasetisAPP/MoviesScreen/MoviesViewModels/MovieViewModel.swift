//
//  MoviesViewModel.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 17/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation

/// Movies ViewModel creates an object array of movies with them properties
class MoviesViewModel {
    //MARK: Properties
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    
    struct Constants {
        let firstTimeLaunchOnBoardingUserDefaults = "hasLaunchedBefore"
        let searchBarHint = "searchBarHint"
        let filterButtonImage = "slider.horizontal.3"
        let showboarding = "firstTimeOnBoarding"
        let moviecell = "Movie"
    }
    
    let constants = Constants()
    
    // MARK: Constructor
    init() {
        self.movies = hardCodeMovies()
    }
    
    // MARK: Functions
    func getMoviesCount(isFiltering: Bool) -> Int {
        return isFiltering ? filteredMovies.count : movies.count
    }
    
    func getMovie(_ indexPath: Int, isFiltering: Bool) -> Movie {
        return isFiltering ? filteredMovies[indexPath] : movies[indexPath]
    }
    
    func setFilteredMovies(_ searchText: String) {
        filteredMovies = movies.filter { (movie: Movie) -> Bool in
            let textInTitle = movie.movieTitle.lowercased().contains(searchText.lowercased())
            let textInActors = movie.movieStars.lowercased().contains(searchText.lowercased())
            let textInDirector = movie.movieDirector.lowercased().contains(searchText.lowercased())
            return textInTitle || textInActors || textInDirector
        }
    }
    
    func sortMoviesAlphabetically() {
        movies.sort { $0.movieTitle < $1.movieTitle }
    }
    
    func sortMoviesRandomly() {
        movies.shuffle()
    }

    func didOnBoardingLaunch() -> Bool {
        return UserDefaults.standard.bool(forKey: constants.firstTimeLaunchOnBoardingUserDefaults)
    }
    func setLaunchedBefore() {
        UserDefaults.standard.set(true, forKey: constants.firstTimeLaunchOnBoardingUserDefaults)
    }

}
