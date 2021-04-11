//
//  LognVC.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(cellType: LogoCell.self)
            tableView.registerCell(cellType: TitleTextFieldCell.self)
            tableView.registerCell(cellType: ButtonCell.self)
            tableView.setdefaults()
        }
    }
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        self.navbarTitleText = viewModel.screenTitle
        viewModel.viewModelDelegate = self
        super.viewDidLoad()
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

extension LoginVC: UITableViewDataSource {
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
        viewModel.formatCell(cell, rowModel: row)
        return cell
    }
}


extension LoginVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension LoginVC: LoginViewModelDelegates {
}
