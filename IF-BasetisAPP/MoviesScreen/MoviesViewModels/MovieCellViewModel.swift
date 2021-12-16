//
//  MovieCellViewModel.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 22/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import UIKit

/// Movie Cell ViewModel set a movie and get image property
class MovieCellViewModel {
    // MARK: Properties
    private var movie = Movie(movieTitle: "", movieImage: "", movieDirector: "", movieStars: "", movieDesc: "")
    
    // MARK: Functions
    func setMovie(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieImage() -> UIImage {
        guard let image = UIImage(named: movie.movieImage) else {
            return UIImage()
        }
        return image
    }
    
    func getMovieTitle(movie: Movie) -> String {
        let title = movie.movieTitle
        return title
    }
    
}
