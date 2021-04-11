//
//  LoginViewModel.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import UIKit

protocol LoginViewModelDelegates {
}



class LoginViewModel: NSObject {
    var screenTitle = "Login"
    var viewModelDelegate: LoginViewModelDelegates?
    var passwordTextfiled: UITextField?
    var isSecurePassword = true {
        didSet {
            passwordTextfiled?.isSecureTextEntry = isSecurePassword
        }
    }
    let rows = [
        RowModel(identifier: LogoCell.cellIdentifier(), title: "", height: LogoCell().cellHeight, cellType: .logo),
        RowModel(identifier: TitleTextFieldCell.cellIdentifier(), title: "Enter UserName", height: TitleTextFieldCell().cellHeight, cellType: .username),
        RowModel(identifier: TitleTextFieldCell.cellIdentifier(), title: "Enter Password", height: TitleTextFieldCell().cellHeight, cellType: .password),
        RowModel(identifier: TitleTextFieldCell.cellIdentifier(), title: "Select Country", height: TitleTextFieldCell().cellHeight, cellType: .country),
        RowModel(identifier: ButtonCell.cellIdentifier(), title: "Login", height: ButtonCell().cellHeight, cellType: .login),
        RowModel(identifier: ButtonCell.cellIdentifier(), title: "Register", height: ButtonCell().cellHeight, cellType: .register)
    ]
    
    func formatCell(_ cell: UITableViewCell, rowModel: RowModel) {
        if let cell = cell as? TitleTextFieldCell {
            cell.label.text = rowModel.title
            cell.textfield.placeholder = rowModel.title
            cell.textfield.delegate = self
            
            if rowModel.cellType == .password && cell.textfield.rightView == nil {
                passwordTextfiled = cell.textfield
                passwordTextfiled?.isSecureTextEntry = isSecurePassword
                let showBtn = UIHelper.addShowPassworButtonToTextfield(textfield: cell.textfield, target: self)
                showBtn.addTarget(self, action: #selector(self.showPassClicked(_:)), for: .touchUpInside)
            }
        } else if let cell = cell as? ButtonCell {
            cell.btn.setTitle(rowModel.title, for: .normal)
            cell.btn.removeTarget(nil, action: nil, for: .allEvents)
            if rowModel.cellType == .login {
                cell.btn.addTarget(self, action: #selector(self.loginClicked), for: .touchUpInside)
            } else if rowModel.cellType == .register {
                cell.btn.addTarget(self, action: #selector(self.registerClicked), for: .touchUpInside)
            }
        }
    }
    
    @IBAction func loginClicked() {
        print("loginClicked")
    }
    
    @IBAction func registerClicked() {
        print("registerClicked")

    }

    @IBAction func showPassClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isSecurePassword = !sender.isSelected
    }
}

extension LoginViewModel: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.restorationIdentifier
        return false
    }
}


struct RowModel {
    let identifier: String
    var title: String
    let height: CGFloat
    let cellType: CellType
}

enum CellType {
    case logo, username, password, country, login, register
}
