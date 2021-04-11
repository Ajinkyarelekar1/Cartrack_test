//
//  CountryListVC.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit

protocol CountryListVCDelegate {
    func selectedCountry(country: String)
}

class CountryListVC: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    let viewModel = CountryListViewModel()
    var delegate: CountryListVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        navbarTitleText = "Select Country"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountryListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") else {
            fatalError("failed to create countryCell")
        }
        cell.textLabel?.text = viewModel.filteredList[indexPath.row]
        return cell
    }
    
    
}

extension CountryListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedCountry(country: viewModel.filteredList[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}

extension CountryListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(filterText: searchText)
    }
}

extension CountryListVC: CountryListViewModelDelegate {
    func reloadList() {
        tableView.reloadData()
    }
}
