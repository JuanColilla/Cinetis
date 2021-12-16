//
//  MovieDetailsViewController.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 27/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var starsText: UITextView!
    @IBOutlet weak var movieDescText: UITextView!
    @IBOutlet weak var ratingStackView: RatingController!
    @IBOutlet weak var ratingStackViewTwo: RatingController!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movieDetailViewModel: MovieDetailViewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPersonalRating()
    }
    
    func setupUI() {
        self.title = movieDetailViewModel.movie?.movieTitle
        self.movieImage.image = UIImage(named: movieDetailViewModel.movie?.movieImage ?? "")
        self.directorLabel.text = movieDetailViewModel.movie?.movieDirector
        self.starsText.text = movieDetailViewModel.movie?.movieStars
        self.movieDescText.text = movieDetailViewModel.movie?.movieDesc
        movieImage.layer.cornerRadius = 15
        favoriteButton.isSelected = movieDetailViewModel.getFavoriteInfo()
    }
    
    func setupPersonalRating() {
        ratingStackView.movie = movieDetailViewModel.movie
        if movieDetailViewModel.getFavoriteInfo() {
            ratingStackView.changeRatingAbleness(to: true)
            ratingStackView.setCircleRatings(rating: movieDetailViewModel.getRatingIfFavorite())
        } else {
            ratingStackView.changeRatingAbleness(to: false)
        }
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        movieDetailViewModel.setFavoriteInfo()
        favoriteButton.isSelected.toggle()
        if movieDetailViewModel.getFavoriteInfo() {
            ratingStackView.changeRatingAbleness(to: true)
        } else {
            ratingStackView.changeRatingAbleness(to: false)
            ratingStackView.setCircleRatings(rating: 0)
            movieDetailViewModel.movie?.movieRating = 0
        }
    }
    
}
