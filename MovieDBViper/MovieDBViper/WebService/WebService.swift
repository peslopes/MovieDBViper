//
//  WebService.swift
//  MovieDBViper
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import Foundation


// TO USE WebService call WebService.sharedService.*function_Name*.
// Example:
// WebService.sharedService.getPopularMovies{ data, error in
//      guard let data = data, error == nil else{
//          return
//      }
//      ...
// }

class WebService {
    
    static let sharedService = WebService()
    
    let apiKey = "ad28148852ee2cbbb8766d7babbf7c5e"
    
    typealias WebServiceCompletionBlock = (_ data: Data?, _ error: Error?) -> Void
    typealias NowPlayingMoviesCompletionBlock = (_ nowPlayingMovies: NowPlayingMovies?, _ error: Error?) -> Void
    typealias PopularMoviesCompletionBlock = (_ popularMovies: PopularMovies?, _ error: Error?) -> Void
    typealias MoviesDetailsCompletionBlock = (_ moviesDetails: MovieDetails?, _ error: Error?) -> Void
    
    func getCoverFrom(posterPath: String, completion: @escaping WebServiceCompletionBlock) {
        getDataFromURL(urlString: "https://image.tmdb.org/t/p/w500\(posterPath)") { data, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            completion(data, nil)
        }
    }
    
    func getNowPlayingMovies(completion: @escaping NowPlayingMoviesCompletionBlock) {
        getDataFromURL(urlString: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1") { data, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            do {
                let nowPlayingMovies = try JSONDecoder().decode(NowPlayingMovies.self, from: data)
                completion(nowPlayingMovies,nil)
            }
            catch {
                print(error)
            }
        }
    }
    
    func getPopularMovies(completion: @escaping PopularMoviesCompletionBlock) {
        getDataFromURL(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") { data, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            do {
                let popularMovies = try JSONDecoder().decode(PopularMovies.self, from: data)
                completion(popularMovies,nil)
            }
            catch {
                print(error)
            }
        }
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping MoviesDetailsCompletionBlock) {
        getDataFromURL(urlString: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US") { data, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            do {
                let moviesDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(moviesDetails,nil)
            }
            catch {
                print(error)
            }
        }
    }
    
    func getDataFromURL(urlString: String, completion: @escaping WebServiceCompletionBlock) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            completion(data, nil)
        }
        task.resume()
        
    }
}
