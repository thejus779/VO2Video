//
//  MovieDetailsViewModel.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class MovieDetailsViewModel {
    var movie: MovieDetails
    let engine: Engine
    
    init(engine: Engine, movie: MovieDetails) {
        self.movie = movie
        self.engine = engine
    }
    
    var name: String? { movie.title }
    var description: String? { movie.overview }
    var rating: Double? { movie.rating }
    
    var releaseDateString: String? {
        guard let releaseDate = movie.releaseDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: releaseDate)
    }
    
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
    
    func updateFavouriteState() {
        movie.isFavourite.toggle()
        engine.moviesService.updateFavouriteState(movieId: movie.id, isFavourite: movie.isFavourite)
    }
}
