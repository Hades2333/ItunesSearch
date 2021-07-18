//
//  ViewController.swift
//  Search
//
//  Created by Hellizar on 18.07.21.
//

import UIKit

class SearchViewController: UIViewController {

    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
        }
    }

    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: Properties

    var searchResults = [SearchResult]()
    var hasSearched = false

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)

        cellNib = UINib(nibName:
          TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
          TableView.CellIdentifiers.nothingFoundCell)

        searchBar.delegate = self
    }


}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier:
                  TableView.CellIdentifiers.nothingFoundCell,
                  for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                  TableView.CellIdentifiers.searchResultCell,
                  for: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
                cell.nameLabel.text = searchResult.name
                cell.artistNameLabel.text = searchResult.artistName
                return cell
        }
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        if searchBar.text! != "justin" {
            for i in 0...2 {
                let searchResult = SearchResult()
                searchResult.name = String(format: "Fake Result %d for", i)
                searchResult.artistName = searchBar.text!
                searchResults.append(searchResult)
            }
        }
        hasSearched = true
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
