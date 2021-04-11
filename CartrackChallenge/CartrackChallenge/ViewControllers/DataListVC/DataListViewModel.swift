//
//  DataListViewModel.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import UIKit

protocol DataListViewModelDelegate {
    func loadUsers()
}

class DataListViewModel: NSObject {
    var users: [User] = []
    var delegate: DataListViewModelDelegate?
    
    func callFetchUsers() {
        APIHelper.fetchUsers { [unowned self] (users) in
            self.users = users
            self.delegate?.loadUsers()
        } failure: { (errorMessage) in
            if let error = errorMessage {
                Helpers.showErrorAlert(withMessage: error)
            } else {
                Helpers.showDefaultErrorAlert()
            }
        }
    }
    
    func logout(completion: @escaping ()->Void) {
        Helpers.showAlertWithYesNoAction(withTitle: "Are You Sure?", withMessage: "Do you really want to logout", completion: completion)
    }
    
    func formatCell(cell: UITableViewCell, user: User) {
        cell.textLabel?.text = "\(user.id): " + "\(user.name)"
        cell.tintColor = .white
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
    }
}
