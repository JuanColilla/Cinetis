//
//  MovieViewCell.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 16/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

/// Movie Cell Collection ViewController
class MovieViewCell: UICollectionViewCell {
    
    // MARK: Properties
    let cellViewModel = MovieCellViewModel()
    var filteredMovies = [String]()
    
    // MARK: IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: Functions
    /// Content cell. at the moment: there's a movie image
    func setUpUI() {
        movieImageView.image = cellViewModel.getMovieImage()
    }
    
}
