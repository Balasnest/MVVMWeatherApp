//
//  SearchViewModel.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 31/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit
import MapKit

public final class SearchViewModel{
    
    //MARK: Object Instance
    var searchSuggestion = [MKLocalSearchCompletion]()
    
    //MARK: Object Initializers 
    init(searchSuggestion:[MKLocalSearchCompletion]) {
        self.searchSuggestion = searchSuggestion
    }
}

