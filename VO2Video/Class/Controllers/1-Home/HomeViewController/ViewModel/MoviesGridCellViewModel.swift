//
//  MoviesGridCellViewModel.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct MoviesGridCellViewModel {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    var name: String? { movie.title }
    var description: String? { movie.overview }
    var posterImage: URL? { movie.posterImage(of: .medium) }

}

