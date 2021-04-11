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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navBackClikced() {
        self.navigationController?.popViewController(animated: true)
    }
}

