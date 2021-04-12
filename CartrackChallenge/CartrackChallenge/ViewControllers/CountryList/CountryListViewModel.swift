//
//  CountryListViewModel.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
protocol CountryListViewModelDelegate {
    func reloadList()
}

class CountryListViewModel: NSObject {
    static var countryList: [String] {
        let arr = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        return arr.sorted()
    }
    var filteredList = CountryListViewModel.countryList
    var currentSearchText = ""
    var delegate: CountryListViewModelDelegate?
    
    func isValidCountry(country: String) -> Bool {
        return country != "No match found"
    }
    
    func filterList(filterText filter: String) {
        if filter.count > currentSearchText.count && !currentSearchText.isEmpty {
            currentSearchText = filter
            let index = currentSearchText.endIndex
            filteredList = filteredList.filter({index<$0.endIndex && $0[...index].lowercased().contains(currentSearchText.lowercased())})
            if filteredList.isEmpty {
                filteredList.append("No match found")
            }
        } else if !filter.isEmpty {
            currentSearchText = filter
            let index = currentSearchText.endIndex
            filteredList = filteredList.filter({index<$0.endIndex && $0[...index].lowercased().contains(currentSearchText.lowercased())})
        } else {
            filteredList = CountryListViewModel.countryList
        }
        delegate?.reloadList()
    }
}
