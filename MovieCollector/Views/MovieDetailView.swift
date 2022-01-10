//
//  MovieDetailView.swift
//  MovieCollector
//
//  Created by YUAN-TSUNG LIOU on 2022/1/11.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
            
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text(movie.genreText)
                Text("·")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
            HStack(alignment: .top, spacing: 4) {
                if movie.cast != nil && movie.cast!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.movie.cast!.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Director(s)")
                                .font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) { director in
                                Text(director.name)
                            }
                        }
                        
                        if movie.producers != nil && movie.producers!.count > 0 {
                            Text("Producer(s)")
                                .font(.headline)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { producer in
                                Text(producer.name)
                            }
                        }
                        
                        if movie.screenWriter != nil && movie.screenWriter!.count > 0 {
                            Text("Screenwriter(s)")
                                .font(.headline)
                                .padding(.top)
                            ForEach(self.movie.screenWriter!.prefix(2)) { screenWriter in
                                Text(screenWriter.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id)
        }
    }
}