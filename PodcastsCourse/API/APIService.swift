//
//  APIService.swift
//  PodcastsCourse
//
//  Created by 徐冲 on 2018/8/14.
//  Copyright © 2018年 徐冲. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    // singleton
    static let shared = APIService()
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        DispatchQueue.global(qos: .background).async {
            print("Before parser")
            let parser = FeedParser(URL: url)
            print("After parser")
            parser.parseAsync { (result) in
                if let err = result.error {
                    print("Failed to parse feed: ", err)
                    return
                }
                guard let feed = result.rssFeed else {return}
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
            }
        }
    }
    
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


