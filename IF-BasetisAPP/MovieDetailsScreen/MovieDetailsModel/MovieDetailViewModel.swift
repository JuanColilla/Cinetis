//
//  MovieDetailViewModel.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 01/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDetailViewModel {
    
    struct Constants {
        
    }
    
    let constants = Constants()
    var movie: Movie?
    let realm = try? Realm()
    
    func setFavoriteInfo() {
            guard let movie = movie,
                  let realm = realm else {
                return
            }
            do {
                try realm.write {
                    if let realmMovie = realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                        realm.delete(realmMovie)
                    } else {
                        realm.create(Movie.self, value: movie)
                    }
                }
            } catch { print(error) }
        }
        
        func getFavoriteInfo() -> Bool {
            guard let movie = movie,
                  let realm = realm else {
                return false
            }
            return realm.object(ofType: Movie.self, forPrimaryKey: movie.id) != nil
        }

    func getRatingIfFavorite() -> Int {
        guard let movie = movie,
              let realm = realm,
              let realmMovie = realm.object(ofType: Movie.self, forPrimaryKey: movie.id) else {
            return 0
        }
        return realmMovie.movieRating
    }

}
