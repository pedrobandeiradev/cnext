//
//  MovieList.swift
//  CNext
//
//  Created by Pedro Bandeira on 06/01/19.
//  Copyright © 2019 Pedro Bandeira. All rights reserved.
//


import Foundation

//Business Logic. Provides the necessary data to the View Controller to distribute between the views
class MovieList {
    
    var genres: [Genre]?
    
    fileprivate var webServices = MovieListServices()
    
    func getListOfMovies(completion: @escaping(_ list: [Movie]?) ->Void) {
        webServices.requestGenreList { (genreList) in
            self.genres = genreList
            self.webServices.requestMoviesList { (list) in
                completion(list)
            }
        }
    }
    
    func requestGenreListForMovie(genreIDs: [Int]) -> String? {
        var genreList = [String]()
        genreIDs.forEach { (id) in
            genreList += genres?.filter{ $0.id == id }.compactMap{ $0.name ?? "" } ?? []
        }
        return genreList.joined(separator: " , ")
    }
}

fileprivate class MovieListServices {
    
    func requestMoviesList(completion: @escaping (_ response: [Movie]?) -> Void) {
        RestAPI.request(endpoint: URL_FIND_UPCOMING) { (responseData, errorMessage) in
            do {
                guard let data = responseData else {
                    completion(nil)
                    return
                }
                let listOfMovies = try JSONDecoder().decode(MovieResults.self, from: data)
                completion(listOfMovies.results)
            } catch {
                completion(nil)
            }
        }
    }
    
    func requestGenreList(completion: @escaping (_ response: [Genre]?) -> Void) {
        RestAPI.request(endpoint: URL_FIND_GENRES) { (responseData, errorMessage) in
            do {
                guard let data = responseData else {
                    completion(nil)
                    return
                }
                let listOfGenres = try JSONDecoder().decode(GenreResults.self, from: data)
                completion(listOfGenres.genres)
            } catch {
                completion(nil)
            }
        }
    }
}

struct MovieResults: Codable {
    let results: [Movie]?
}

struct Movie: Codable {
    var title: String?
    var overview: String?
    var genre_ids: [Int]?
    var release_date: String?
    var poster_path: String?
    var posterURL: URL? {
        return URL(string: URL_GET_IMAGE + (poster_path ?? ""))
    }
}

struct GenreResults: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    var id: Int?
    var name : String?
}



