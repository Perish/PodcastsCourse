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
    var podcasts = [Podcast]()
    
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
        //确定父视图控制器的视图应该呈现在类型uimoDalpRealTurnCurrror上下文的演示文稿上。如果没有祖先视图控制器设置了这个标志，那么演示者将是根视图控制器。
        self.definesPresentationContext = true
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
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let episodesController = EpisodesController()
        let podcast = self.podcasts[indexPath.row]
        episodesController.podcast = podcast
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a Search Term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // ternary operator
        return self.podcasts.count > 0 ? 0 : 250
    }
    
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
