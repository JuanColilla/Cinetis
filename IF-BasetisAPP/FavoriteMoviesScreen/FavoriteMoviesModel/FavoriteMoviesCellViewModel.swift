//
//  FavoriteMoviesCellViewModel.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 22/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class FavoriteMoviesCellViewModel {
    
    var favoriteMovie = Movie()
    
    func setMovie(movie: Movie) {
        favoriteMovie = movie
    }
    
    func getMovieImage() -> UIImage {
        return UIImage(named: favoriteMovie.movieImage) ?? UIImage()
     }
    
    func getMovieTitle() -> String {
        return favoriteMovie.movieTitle
    }
    
}
