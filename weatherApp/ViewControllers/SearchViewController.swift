//
//  SearchViewController.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 30/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit
import MapKit

//MARK: Delegate for selecting location
protocol SearchPlaceDelegate: class {
    func fetchData(latitude:String,longitude:String) -> Void
}

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var searchCompleter = MKLocalSearchCompleter()
    weak var delegate: SearchPlaceDelegate?
    var latitude:String!
    var longitude:String!
    private var viewModel:SearchViewModel!{
        didSet {
            self.searchTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.becomeFirstResponder()
        self.searchBar.delegate = self
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: UISearchBar delegates
extension SearchViewController:UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCompleter.queryFragment = searchText
        self.searchCompleter.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Utility.shared.convertAddressToCoordinates(address: searchBar.text!) { (location, error) in
            //Converting to Double
            let latitudeValue:Double = (location?.latitude)!
            let longitudeValue:Double = (location?.longitude)!
            //Converting to String
            self.latitude = String(latitudeValue)
            self.longitude = String(longitudeValue)
            //Calling the service to fetch weather report
            self.dismiss(animated: false, completion: {
                self.delegate?.fetchData(latitude:self.latitude , longitude: self.longitude)
            })
        }
    }
}

//MARK: MKLocalSearchCompleter Delegates
extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.viewModel = SearchViewModel(searchSuggestion: completer.results)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.viewModel = SearchViewModel(searchSuggestion: [])
        print(error.localizedDescription)
    }
}

extension SearchViewController: UITableViewDataSource,UITableViewDelegate {
    //MARK: tableview delegate and datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.viewModel != nil) {
            return (self.viewModel?.searchSuggestion.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = self.viewModel?.searchSuggestion[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.placeLabel.text = searchResult?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResult = self.viewModel?.searchSuggestion[indexPath.row]
        self.searchBar.text = searchResult?.title
    }
}
