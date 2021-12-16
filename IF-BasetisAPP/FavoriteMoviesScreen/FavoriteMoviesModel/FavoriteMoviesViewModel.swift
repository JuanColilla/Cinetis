//
//  FavoriteMoviesViewModel.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 22/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteMoviesViewModel {
    
    var favoriteMovies = [Movie]()
    let realm = try? Realm()
    
    init() {
        if let realm = realm {
            favoriteMovies.append(contentsOf: realm.objects(Movie.self))
        }
    }
    
    func getFavoriteMoviesCount() -> Int {
        return favoriteMovies.count
    }
    
    func getMovie(_ indexPath: Int) -> Movie {
        return favoriteMovies[indexPath]
    }
}
