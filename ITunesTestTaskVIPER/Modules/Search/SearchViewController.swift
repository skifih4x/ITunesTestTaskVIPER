//
//  SearchViewController.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    var presenter: SearchPresenterProtocol?
    var musicResults: [MusicResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
    }
    
    private func setupUI() {
        title = "Music Search"
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for songs"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func showLoadingIndicator() {
        tableView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.activityIndicatorView.stopAnimating()
        }

       
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let musicResult = musicResults[indexPath.row]
        cell.textLabel?.text = "\(musicResult.trackName ?? "") - \(musicResult.artistName)"
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showMusicPlayer(with: musicResults[indexPath.row])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, keyword.count >= 3 else { return }
        presenter?.searchMusic(keyword)
    }
}

extension SearchViewController: SearchViewProtocol {
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
    
    func showMusicResults(_ results: [MusicResult]) {
        musicResults = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
}

