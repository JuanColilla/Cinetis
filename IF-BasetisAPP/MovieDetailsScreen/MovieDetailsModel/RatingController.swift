//
//  MovieRatings.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 30/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

/// The RatingController class has three parametres, one for the rating value, and two to define the different stages of a rating ball, a filled one and an empty one.
/// Then it has two functions to be able to set the image as wished, empty if needed or full if chosen.
class RatingController: UIStackView {
    
    var circleRating = 0
    var circleEmptyPic = "circle"
    var circleFilledPic = "largecircle.fill.circle" // change it to your filled star picture name
    var movie: Movie?
    let realm = try? Realm()
    
    /// This function overrides the function draw and adds the custom parametres to it.
    /// In our case we needed to set an image to our button and set that if the button is dragged it should fill itself. It customized the user interaction with the button.
    override func draw(_ rect: CGRect) {
        let circleButtons = self.subviews.filter{$0 is UIButton}
        var circleTag = 1
        for button in circleButtons {
            if let button = button as? UIButton {
                button.setImage(UIImage(systemName: circleEmptyPic), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                button.tag = circleTag
                circleTag += 1
            }
        }
       setCircleRatings(rating:circleRating)
    }
    
    /// This function is the one that sets the correct image of the button (filled or empty) depending on the rating it's given.
    /// - Parameter rating: this is the numeric value of the rating, that starts at 0 and can go far as many circles they are for rating.
    func setCircleRatings(rating: Int) {
        self.circleRating = rating
        let stackSubViews = self.subviews.filter { $0 is UIButton }
        for subView in stackSubViews {
            if let button = subView as? UIButton {
                if button.tag > circleRating {
                    button.setImage(UIImage(systemName: circleEmptyPic), for: .normal)
                } else {
                    button.setImage(UIImage(systemName: circleFilledPic), for: .normal)
                }
            }
        }
    }
    
    func changeRatingAbleness(to value: Bool) {
        let stackSubViews = self.subviews.filter { $0 is UIButton }
        for subView in stackSubViews {
            if let button = subView as? UIButton {
                button.isEnabled = value
            }
        }
    }
    
    /// This function indicaties if the button is pressed and sends the rating it has been given by the user to the next function.
    /// - Parameter sender: the sender can be any of type UIButton.
    @objc func pressed(sender: UIButton) {
        setCircleRatings(rating: sender.tag)
        if let movie = self.movie {
            guard let realm = realm else {
                return
            }
            if let _ = realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                do {
                    try realm.write {
                        movie.movieRating = sender.tag
                        realm.create(Movie.self, value: movie, update: .modified)
                    }
                } catch { print(error) }
            }
        }
    }
    
}
