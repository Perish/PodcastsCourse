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
        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
    }
    
    fileprivate func setupTableView() {
        //1. register a cell for our tableview
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- UITableView
    
    //2. number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //3. dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        
        let podcast = self.podcasts[indexPath.row]
        cell.podcast = podcast
        
//        let podcast = self.podcasts[indexPath.row]
//        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
//        cell.textLabel?.numberOfLines = -1
//        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}
