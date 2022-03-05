//
//  MovieBackdropCarouseView.swift
//  MovieCollector
//
//  Created by YUAN-TSUNG LIOU on 2022/1/10.
//

import SwiftUI

struct MovieBackdropCarouseView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieBackdropCard(movie: movie)
                                .frame(width: 272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
        
    }
}

struct MovieBackdropCarouseView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarouseView(title: "Latest", movies: Movie.stubbedMovies)
    }
}
