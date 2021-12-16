//
//  FavoriteMoviesViewController.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 22/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let favoriteMoviesViewModel = FavoriteMoviesViewModel()
    let favoriteMoviesCellViewModel = FavoriteMoviesCellViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Double(UIScreen.main.bounds.width)
        let horizontalMargin = 40.0
        let cellSizeRatio = 250.0/175
        let cellWidth = (screenWidth - horizontalMargin)/2
        let cellHeight = cellSizeRatio*cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMoviesViewModel.getFavoriteMoviesCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let favoriteMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovie", for: indexPath) as? FavoriteMoviesViewCell else {
            return UICollectionViewCell()
        }
        favoriteMovieCell.favoriteMoviesCellViewModel.setMovie(movie: favoriteMoviesViewModel.getMovie(indexPath.row))
        favoriteMovieCell.setUpUI()
        favoriteMovieCell.layer.cornerRadius = 15
        return favoriteMovieCell
    }
}
