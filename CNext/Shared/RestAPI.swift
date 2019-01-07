//
//  RestAPI.swift
//  CNext
//
//  Created by Pedro Bandeira on 06/01/19.
//  Copyright © 2019 Pedro Bandeira. All rights reserved.
//

import Foundation
import Alamofire

//Endpoints
let API_KEY = "1f54bd990f1cdfb230adb312546d765d"
let URL_BASE = "https://api.themoviedb.org"
let URL_FIND_UPCOMING = "/3/movie/upcoming?api_key="
let URL_FIND_GENRES = "/3/genre/movie/list?api_key="
let URL_GET_IMAGE = "https://image.tmdb.org/t/p/w500"

//REST API responsible for handling network requests using Alamofire
class RestAPI {
    static func request(endpoint:String, completion: @escaping (_ response: Data?, _ errorStr: String? )->Void) {
        AF.request(URL_BASE + endpoint + API_KEY).responseJSON { (response) in

            switch response.result {
            case .success(_):
                completion(response.data, nil)
                break
            case .failure(_):
                completion(nil, response.result.error.debugDescription )
                break
            }
        }
    }
}
