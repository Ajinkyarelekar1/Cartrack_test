//
//  UserDetailsViewModel.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import UIKit

protocol UserDetailsViewModelDelegate {
    func showWebSite(url: String)
    func showUserLocationOnMap()
}

class UserDetailsViewModel: NSObject {
    var user: User?
    var delegate: UserDetailsViewModelDelegate?
    let rows: [DetailRow] = [
        DetailRow(identifier: UIConstants.textCellIdentifier, height: UIConstants.textCellHeight, cellType: .name),
        DetailRow(identifier: UIConstants.textCellIdentifier, height: UIConstants.textCellHeight, cellType: .username),
        DetailRow(identifier: UIConstants.textCellIdentifier, height: UIConstants.textCellHeight, cellType: .email),
        DetailRow(identifier: AddressCell.cellIdentifier(), height: AddressCell().cellHeight, cellType: .address),
        DetailRow(identifier: UIConstants.textCellIdentifier, height: UIConstants.textCellHeight, cellType: .phone),
        DetailRow(identifier: CompanyCell.cellIdentifier(), height: CompanyCell().cellHeight, cellType: .company),
        DetailRow(identifier: ButtonCell.cellIdentifier(), height: ButtonCell().cellHeight, cellType: .website)
    ]
    
    func formatCell(cell: UITableViewCell, row: DetailRow) {
        switch row.cellType {
        case .name:
            cell.textLabel?.text = "Name: " + (user?.name ?? "")
        case .username:
            cell.textLabel?.text = "Username: " + (user?.username ?? "")
        case .email:
            cell.textLabel?.text = "Email: " + (user?.email ?? "")
        case .address:
            if let cell = cell as? AddressCell {
                cell.lblStreet.text = user?.address.street
                cell.lblSuite.text = user?.address.suite
                cell.lblcity.text = user?.address.city
                cell.lblZip.text = user?.address.zipcode
                cell.btnMap.removeTarget(nil, action: nil, for: .touchUpInside)
                cell.btnMap.addTarget(self, action: #selector(self.openMap), for: .touchUpInside)
            }
        case .phone:
            cell.textLabel?.text = "Phone Number: " + (user?.phone ?? "")
        case .website:
            if let cell = cell as? ButtonCell {
                cell.btn.setTitle("Visit: \(user?.website ?? "-")", for: .normal)
                cell.btn.removeTarget(nil, action: nil, for: .touchUpInside)
                cell.btn.addTarget(self, action: #selector(self.openWebSite), for: .touchUpInside)
            }
        case .company:
            if let cell = cell as? CompanyCell {
                cell.lblName.text = user?.company.name
                cell.lblCatchPhrase.text = user?.company.catchPhrase
                cell.lblbs.text = user?.company.bs
            }
        }
    }
    
    @IBAction func callNow() {
        guard let phone = user?.phone, let number = URL(string: "tel://" + phone) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            UIApplication.shared.openURL(number)
        }
    }
    
    @IBAction func openWebSite() {
        if var website = user?.website {
            if website.lowercased().hasPrefix("http://")==false {
                website = "http://" + website
            }
            delegate?.showWebSite(url: website)
        }
    }
    
    @IBAction func openMap() {
        delegate?.showUserLocationOnMap()
    }
}

struct DetailRow {
    let identifier: String
    let height: CGFloat
    let cellType: DetailCellType
}

enum DetailCellType {
    case name, username, email, address, phone, website, company
}
