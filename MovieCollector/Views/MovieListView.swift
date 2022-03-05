//
//  MovieListView.swift
//  MovieCollector
//
//  Created by YUAN-TSUNG LIOU on 2022/1/10.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if nowPlayingState.movies != nil {
                    MoviePosterCarouseView(title: "Now Playing", movies: nowPlayingState.movies!)
                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                } else {
                    LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                        self.nowPlayingState.loadMovies(with: .nowPlaying)
                    }
                }
                
                if upcomingState.movies != nil {
                    MovieBackdropCarouseView(title: "Upcoming", movies: upcomingState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                        self.upcomingState.loadMovies(with: .upcoming)
                    }
                }
                
                if topRatedState.movies != nil {
                    MovieBackdropCarouseView(title: "Top Rated", movies: topRatedState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                        self.topRatedState.loadMovies(with: .upcoming)
                    }
                }
                
                if popularState.movies != nil {
                    MovieBackdropCarouseView(title: "Popular", movies: popularState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                        self.popularState.loadMovies(with: .popular)
                    }
                }
            }
            .navigationBarTitle("TMDB")
            .onAppear {
                self.nowPlayingState.loadMovies(with: .nowPlaying)
                self.upcomingState.loadMovies(with: .upcoming)
                self.topRatedState.loadMovies(with: .topRated)
                self.popularState.loadMovies(with: .popular)
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
