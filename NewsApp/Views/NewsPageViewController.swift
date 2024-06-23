//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Tommy Han on 23/6/2024.
//

import Foundation
import UIKit
import Alamofire

class NewsPageViewController: UIViewController {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyView = EmptyListView()
    
    private var dataSource: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBlue
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: API calls
        
        AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=183daca270264bad86fc5b72972fb82a", method: .get)
            .responseDecodable(of: ArticlesRequest.self) { [weak self] response in
                guard let self else { return }
                
                switch response.result {
                case let .success(articlesResponse):
                    dataSource = articlesResponse.articles
                case let .failure(error):
                    // TODO: Handle more elegantly using Alerts.
                    print(error.localizedDescription)
                }
            }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        tableView.backgroundView = dataSource.isEmpty ? emptyView : nil
        tableView.register(NewsArticleTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension NewsPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articleLink = dataSource[indexPath.row].url else { return }
        
        guard let url = URL(string: articleLink) else { return }
        
        // Naivgate to original news source
        UIApplication.shared.open(url)
    }
}

extension NewsPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsArticleTableViewCell
        
        cell.setupView(article: dataSource[indexPath.row])
        
        return cell
    }
}

extension NewsPageViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
    }
}
