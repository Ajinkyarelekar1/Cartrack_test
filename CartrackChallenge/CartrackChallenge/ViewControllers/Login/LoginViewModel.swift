//
//  LoginViewModel.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import UIKit

protocol LoginViewModelDelegates {
    func showCountrySelection()
    func showUsersVC()
    func reset()
}

class LoginViewModel: NSObject {
    var screenTitle = "Login"
    var delegate: LoginViewModelDelegates?
    var passwordTextfiled: UITextField?
    var loginUser = LoginUser()
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
            cell.textfield.autocorrectionType = .no
            cell.textfield.delegate = self
            
            if rowModel.cellType == .password {
                passwordTextfiled = cell.textfield
                cell.textfield.tag = TextFiledTag.password.rawValue
                cell.textfield.text = loginUser.password
                passwordTextfiled?.isSecureTextEntry = isSecurePassword
                if cell.textfield.rightView == nil {
                    let showBtn = UIHelper.addShowPassworButtonToTextfield(textfield: cell.textfield, target: self)
                    showBtn.addTarget(self, action: #selector(self.showPassClicked(_:)), for: .touchUpInside)
                }
            } else if rowModel.cellType == .country {
                cell.textfield.text = loginUser.country
                cell.textfield.tag = TextFiledTag.country.rawValue
            } else if rowModel.cellType == .username {
                cell.textfield.tag = TextFiledTag.username.rawValue
                cell.textfield.text = loginUser.username
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
        guard DBhelper.shared.isUserExists() else {
            Helpers.showErrorAlert(withMessage: "No user exists please click register to create this user.")
            return
        }
        guard let uName = loginUser.username, !uName.isEmpty else {
            Helpers.showErrorAlert(withMessage: "Please enter Username.")
            return
        }
        guard let password = loginUser.password, !password.isEmpty else {
            Helpers.showErrorAlert(withMessage: "Please enter Password.")
            return
        }
        guard let country = loginUser.country, !country.isEmpty else {
            Helpers.showErrorAlert(withMessage: "Please select Country.")
            return
        }
        
        if DBhelper.shared.authenticateUser(username: uName, password: password, country: country) {
            loginUser = LoginUser()
            delegate?.reset()
            delegate?.showUsersVC()
        } else {
            Helpers.showAlert(withTitle: "Authentication Failed!", withMessage: "Please check username and password.")
        }
    }
    
    @IBAction func registerClicked() {
        guard let uName = loginUser.username, !uName.isEmpty else {
            Helpers.showErrorAlert(withMessage: "Please enter Username.")
            return
        }
        
        if DBhelper.shared.isUserExists(username: uName) {
            Helpers.showErrorAlert(withMessage: "User already exists with this username. Please try different username.")
            return
        }
        
        guard let password = loginUser.password, !password.isEmpty else {
            Helpers.showErrorAlert(withMessage: "Please enter Password.")
            return
        }
        guard let country = loginUser.country, !country.isEmpty else {
            Helpers.showErrorAlert(withMessage: "Please select Country.")
            return
        }
        
        Helpers.showAlertWithYesNoAction(withTitle: "Create New User?", withMessage: "Are you surely want to create new user \(uName) with country \(country)?") {
            DispatchQueue.main.async { [unowned self] in
                if DBhelper.shared.insertUser(username: uName, password: password, country: country) {
                    Helpers.showSuccessAlert(withMessage: "User created successfully. Please proceed with login.")
                    loginUser = LoginUser()
                    delegate?.reset()
                } else {
                    Helpers.showErrorAlert(withMessage: "Failed to create user, Please try again later.")
                }
            }
        }
    }

    @IBAction func showPassClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isSecurePassword = !sender.isSelected
    }
}

extension LoginViewModel: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case TextFiledTag.username.rawValue:
            loginUser.username = textField.text
        case TextFiledTag.password.rawValue:
            loginUser.password = textField.text
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == TextFiledTag.country.rawValue {
            delegate?.showCountrySelection()
            return false
        }
        return true
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

enum TextFiledTag: Int {
    case username = 11
    case password = 12
    case country = 13
}
