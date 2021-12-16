//
//  FavoriteMoviesViewCell.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 22/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class FavoriteMoviesViewCell: UICollectionViewCell {
    
    let favoriteMoviesCellViewModel = FavoriteMoviesCellViewModel()
    @IBOutlet weak var favoriteMovieImageView: UIImageView!
    
    func setUpUI() {
        favoriteMovieImageView.image = favoriteMoviesCellViewModel.getMovieImage()
    }
}
