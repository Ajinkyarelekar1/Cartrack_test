//
//  DataListVC.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit

class DataListVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: UIConstants.textCellIdentifier)
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    let viewModel = DataListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navbarTitleText = "Users"
        viewModel.delegate = self
        viewModel.callFetchUsers()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutClicked() {
        viewModel.logout {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension DataListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.users[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.textCellIdentifier) else {
            fatalError("failed to create cell userCell")
        }
        viewModel.formatCell(cell: cell, user: user)
        return cell
    }
}

extension DataListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        showDetailsVC(user: viewModel.users[indexPath.row])
    }
}


extension DataListVC: DataListViewModelDelegate {
    func loadUsers() {
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
        }
    }
    
    func showDetailsVC(user: User) {
        if let detailsVC = UIHelper.vcFromSB(from: .main, withIdentifier: UserDetailsVC.vcIdentifier) as? UserDetailsVC {
            detailsVC.updateUser(user: user)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

}
