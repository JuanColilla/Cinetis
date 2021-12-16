//
//  Movie.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 17/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object {
    // MARK: Properties
    @Persisted var movieTitle: String = ""
    @Persisted var movieImage: String = ""
    @Persisted var movieDirector: String = ""
    @Persisted var movieStars: String = ""
    @Persisted var movieDesc: String = ""
    @Persisted var id = ""
    @Persisted dynamic var movieRating = 0
    
    // MARK: Constructor
    convenience init(movieTitle: String, movieImage: String, movieDirector: String, movieStars: String, movieDesc: String) {
        self.init()
        self.movieTitle = movieTitle
        self.movieImage = movieImage
        self.movieDirector = movieDirector
        self.movieStars = movieStars
        self.movieDesc = movieDesc
        self.id = "\(movieTitle) + \(movieDirector)"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

let movieDetailModel: MovieDetailViewModel = MovieDetailViewModel()

// MARK: Functions
func hardCodeMovies() -> [Movie] {
    var movies: [Movie] = [Movie]()
    movies.append(Movie(movieTitle: "Her",
                        movieImage: "her",
                        movieDirector: "Spike Jonze",
                        movieStars: "Joanquin Phoenix, Amy Adams, Scarlett Johansson",
                        movieDesc: "In a near future, a lonely writer develops an unlikely relationship with " +
                            "an operating system designed to meet his every need."))
    movies.append(Movie(movieTitle: "Ex_Machina",
                        movieImage: "exmachina",
                        movieDirector: "Alex Garlands",
                        movieStars: "Alicia Vikander, Domhnall Gleeson, Oscar Isaac",
                        movieDesc: "A young programmer is selected to participate in a ground-breaking experiment in synthetic " +
                            "intelligence by evaluating the human qualities of a highly advanced humanoid A.I."))
    movies.append(Movie(movieTitle: "Avatar",
                        movieImage: "avatar",
                        movieDirector: "Michael Dante DiMartino, Bryan Konietzko",
                        movieStars: "Dee Bradley Baker, Zach Tyler",
                        movieDesc: "In a war-torn world of " +
                            "elemental magic, a young boy reawakens to undertake a dangerous mystic quest to " +
                            "fulfill his destiny as the Avatar, and bring peace to the world."))
    movies.append(Movie(movieTitle: "El Castillo Ambulante",
                        movieImage: "castilloambulante",
                        movieDirector: "Hayao Miyazaki",
                        movieStars: "Chieko Baisho, Takuya Kimura, Tatsuya Gashuin",
                        movieDesc: "When an unconfident young woman is cursed with an old body by a spiteful witch, " +
                            "her only chance of breaking the spell lies with a self-indulgent yet insecure young " +
                            "wizard and his companions in his legged, walking castle."))
    movies.append(Movie(movieTitle: "Avengers Endgame",
                        movieImage: "avengers",
                        movieDirector: "Anthony Russo, Joe Russo",
                        movieStars: "Robert Downey Jr., Chris Evans, Mark Ruffalo",
                        movieDesc: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. " +
                            "With the help of remaining allies, the Avengers assemble once more in order to " +
                            "reverse Thanos' actions and restore balance to the universe."))
   return movies
}
