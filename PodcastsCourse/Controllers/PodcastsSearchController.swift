//
//  PodcastsSearchController.swift
//  PodcastsCourse
//
//  Created by 徐冲 on 2018/8/14.
//  Copyright © 2018年 徐冲. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
    var podcasts = [
        Podcast(trackName: "Lets Build That App", artistName: "Brain Voong"),
        Podcast(trackName: "Some Podcast", artistName: "Some Author")
    ]
    
    let cellId = "cellId"
    
    // let's implement a UISearchController
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    //MARK:- Setup Work
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        // 指示在滚动任何底层内容时是否隐藏了集成搜索栏
        navigationItem.hidesSearchBarWhenScrolling = false
        // 指示在搜索过程中基础内容是否被遮挡
        searchController.dimsBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
        // later implement Alamofire to search iTunes API
        
//        let url = "https://itunes.apple.com/search?term=\(searchText)"
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                self.podcasts = searchResult.results
                self.tableView.reloadData()
            } catch let decodeErr {
                print("Failed to decode: ", decodeErr)
            }
            
        }
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
    fileprivate func setupTableView() {
        //1. register a cell for our tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- UITableView
    
    //2. number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //3. dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        
        return cell
    }
}
