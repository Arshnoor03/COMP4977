//
//  MovieDetailsView.swift
//  Arshnoor_practice
//
//  Created by Arshnoor Kaur Boparai on 2023-10-25.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    let coreDataManager: CoreDataManager
    
    @State private var movieTitle: String = ""
    @State private var movieYear: String = ""
    
    init(movie: Movie, coreDataManager: CoreDataManager) {
            self.movie = movie
            self.coreDataManager = coreDataManager
            _movieTitle = State(initialValue: movie.title ?? "")
            _movieYear = State(initialValue: String(movie.year))
        }

    var body: some View {
        TextField("Movie Title", text: $movieTitle).textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("Movie Year", text: $movieYear).textFieldStyle(RoundedBorderTextFieldStyle())
        
        Button("Update"){
            if !movieTitle.isEmpty {
                movie.title = movieTitle
            }
            
            if !movieYear.isEmpty{
                let intMovieYear: Int? = Int(movieYear)
                movie.year = Int16(intMovieYear!)
            }
            
            coreDataManager.updateMovie()
        }
    }
}

#Preview {
    let dm = CoreDataManager()
    var movies = dm.getAllMovies()
    if (movies.isEmpty){
        dm.saveMovie(title: "Bogus", year: 2000)
        movies = dm.getAllMovies()
    }
    
    return MovieDetailsView(movie: movies[0], coreDataManager: dm)
}
