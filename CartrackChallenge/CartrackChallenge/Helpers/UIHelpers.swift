//
//  UIHelpers.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import UIKit

struct UIHelper {
    static func rootViewController() -> UIViewController? {
        return UIStoryboard(name: StoryBoards.main.rawValue,
                            bundle: .main).instantiateInitialViewController()
    }
    static func vcFromSB(from storyboard: StoryBoards, withIdentifier identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        return storyBoard.instantiateViewController(withIdentifier: identifier)
    }
    static func addShowPassworButtonToTextfield(textfield: UITextField, target: AnyObject) -> UIButton {
        let showPassView = UIView(frame: CGRect(x: 0, y: 0, width: textfield.frame.height + 8, height: textfield.frame.height))
        let showBtn = UIButton.showPassWordButton(withTarget: target, andHeight: textfield.frame.height)
        showPassView.addSubview(showBtn)
        textfield.rightView = showPassView
        textfield.rightViewMode = .always
        return showBtn
    }
}


extension UIView {
    var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    func roundedCorners(withColor color: UIColor = .clear) {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
}

extension UIButton {
    static func showPassWordButton(withTarget target: AnyObject, andHeight height: CGFloat) -> UIButton {
        let btnShowPassword = UIButton(type: .custom)
        btnShowPassword.frame = CGRect(x: 0, y: 0, width: height, height: height)
        btnShowPassword.setImage(UIImage(named: "passwordhide")!, for: .normal)
        btnShowPassword.setImage(UIImage(named: "passwordshow")!, for: .selected)

        return btnShowPassword
    }
}

extension UITableView {
    func setdefaults() {
        self.separatorStyle = .none
        self.tableFooterView = UIView()
    }
    func registerCell<T: BaseTableCell>(cellType: T.Type) {
        self.register(cellType.nib(), forCellReuseIdentifier: cellType.cellIdentifier())
    }
}

extension UITextField {
    func leftPadding() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
    }
}
