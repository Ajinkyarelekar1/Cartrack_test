//
//  ViewController.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    var navbarTitleText: String? {
        didSet {
            self.navigationController?.navigationBar.topItem?.title = navbarTitleText
        }
    }
    class var vcIdentifier: String {
        return String(describing: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpKeyboardHandling()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardHandling()
    }
    
    @IBAction func navBackClikced() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: - Keyboard Handling
extension BaseViewController {
    private func getAllTextFields(fromView view: UIView) -> [UITextField] {
        var textFields: [UITextField] = []
        var isTextFeildFirstResponder = false
        view.subviews.forEach { (view) in
            guard !isTextFeildFirstResponder else { return }
            if view is UITextField {
                if let textFeild = view as? UITextField {
                    if textFeild.isFirstResponder {
                        textFields.append(textFeild)
                        isTextFeildFirstResponder = true
                    } else {
                        textFields.append(textFeild)
                    }
                }
            } else {
                textFields.append(contentsOf: getAllTextFields(fromView: view))
            }
        }
        return textFields
    }
    open func setUpKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
    }
    open func removeKeyboardHandling() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillChangeFrameNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        getAllTextFields(fromView: view).forEach { $0.resignFirstResponder() }
    }
    @objc private func showKeyboard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardYAxis = view.frame.height - keyboardSize.height
            let textField = getAllTextFields(fromView: view).filter { $0.isFirstResponder }.first
            if let textfieldYAxis = textField?.globalPoint?.y,
                let textFeildHeight = textField?.frame.height,
                keyboardYAxis < textfieldYAxis + textFeildHeight {
                view.frame.origin.y -= ((textfieldYAxis - keyboardYAxis) + textFeildHeight)
            }
        }
    }
    @objc private func hideKeyboard(notification: Notification) {
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: UIView.AnimationOptions.RawValue(truncating: curve)), animations: {
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y = 0
                }
            }, completion: nil)
        }
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
