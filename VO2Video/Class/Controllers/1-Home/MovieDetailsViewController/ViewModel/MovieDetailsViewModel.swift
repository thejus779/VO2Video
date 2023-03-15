//
//  MovieDetailsViewModel.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct MovieDetailsViewModel {
    let movie: MovieDetails
    
    init(movie: MovieDetails) {
        self.movie = movie
    }
    
    var name: String? { movie.title }
    var description: String? { movie.overview }
    var rating: Double? { movie.rating }
    var releaseDate: Date? { movie.releaseDate }
    var isFavourite: Bool {
        movie.isFavourite
    }
    var runtime: String? {
        if let runtime = movie.runtime {
            return R.string.localizable.movieDetailsRuntime(runtime)
        } else {
            return nil
        }
        
    }
    var posterImage: URL? { movie.posterImage(of: .large) }
    
}
