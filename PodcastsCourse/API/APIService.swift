//
//  APIService.swift
//  PodcastsCourse
//
//  Created by 徐冲 on 2018/8/14.
//  Copyright © 2018年 徐冲. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    // singleton
    static let shared = APIService()
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
            } catch let decodeErr {
                print("Failed to decode: ", decodeErr)
            }
            
        }
    }
    
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
}


