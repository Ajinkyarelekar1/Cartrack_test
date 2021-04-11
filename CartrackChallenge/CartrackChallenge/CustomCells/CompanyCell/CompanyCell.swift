//
//  AddressCell.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit

class CompanyCell: BaseTableCell, CustomCellProtocol {
    var cellHeight: CGFloat = 126
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCatchPhrase: UILabel!
    @IBOutlet weak var lblbs: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
