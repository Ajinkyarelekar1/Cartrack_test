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
    static func addShowPassworButtonToTextfield(textfield: UITextField, target: AnyObject) {
        let showPassView = UIView(frame: CGRect(x: 0, y: 0, width: textfield.frame.height + 8, height: textfield.frame.height))
        
        showPassView.addSubview(UIButton.showPassWordButton(withTarget: target, andHeight: textfield.frame.height))
        textfield.rightView = showPassView
        textfield.rightViewMode = .always

    }
}


extension UIView {
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
        btnShowPassword.setTitle("Show", for: .normal)
        btnShowPassword.setTitle("Hide", for: .selected)
        
        return btnShowPassword
    }
}
