//
//  UserDetailsVC.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit
import SafariServices

class UserDetailsVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: UIConstants.textCellIdentifier)
            tableView.registerCell(cellType: AddressCell.self)
            tableView.registerCell(cellType: ButtonCell.self)
            tableView.registerCell(cellType: CompanyCell.self)
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    let viewModel = UserDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navbarTitleText = "User Details"
        viewModel.delegate = self
    }
    
    func updateUser(user: User) {
        viewModel.user = user
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

extension UserDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier) else {
            fatalError("failed to create cell \(row.identifier)")
        }
        viewModel.formatCell(cell: cell, row: row)
        return cell
    }
}

extension UserDetailsVC: UITableViewDelegate {
    
}

extension UserDetailsVC: UserDetailsViewModelDelegate {
    func showWebSite(url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    func showUserLocationOnMap() {
        if let latitude = viewModel.user?.address.geo.lat, let longitude = viewModel.user?.address.geo.lng {
            if let mapVC = UIHelper.vcFromSB(from: .main, withIdentifier: MapVC.vcIdentifier) as? MapVC {
                mapVC.updateLatLong(lat:  latitude, lng: longitude)
                self.navigationController?.pushViewController(mapVC, animated: true)
            }
        }
    }
}
