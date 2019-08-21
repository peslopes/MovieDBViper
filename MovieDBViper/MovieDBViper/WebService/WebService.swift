//
//  WebService.swift
//  MovieDBViper
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import Foundation
import SystemConfiguration


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
    typealias SearchMoviesCompletionBlock = (_ nowPlayingMovies: NowPlayingMovies?, _ error: Error?) -> Void
    
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    func search(text: String, completion: @escaping SearchMoviesCompletionBlock) {
        let stringToSearch = text.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        getDataFromURL(urlString: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(stringToSearch)&page=1&include_adult=false") { data, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let nowPlayingMovies = try JSONDecoder().decode(NowPlayingMovies.self, from: data)
                    completion(nowPlayingMovies,nil)
                }
                catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func getCoverFrom(posterPath: String?) -> Data? {
        if posterPath == nil {
            return nil
        }
        else {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath!)") {
                do {
                    let data = try Data(contentsOf: url)
                    return data
                }
                catch {
                    return nil
                }
            }
            else {
                return nil
            }
        }
    }
    
    func getNowPlayingMovies(completion: @escaping NowPlayingMoviesCompletionBlock) {
        getDataFromURL(urlString: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1") { data, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let nowPlayingMovies = try JSONDecoder().decode(NowPlayingMovies.self, from: data)
                    completion(nowPlayingMovies,nil)
                }
                catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func getPopularMovies(completion: @escaping PopularMoviesCompletionBlock) {
        getDataFromURL(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") { data, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let popularMovies = try JSONDecoder().decode(PopularMovies.self, from: data)
                    completion(popularMovies,nil)
                }
                catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping MoviesDetailsCompletionBlock) {
        getDataFromURL(urlString: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US") { data, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let moviesDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                    completion(moviesDetails,nil)
                }
                catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, nil)
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
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                completion(data, nil)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
        
    }
}
