//
//  AddressCell.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import UIKit

class AddressCell: BaseTableCell, CustomCellProtocol {
    var cellHeight: CGFloat = 195
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblSuite: UILabel!
    @IBOutlet weak var lblcity: UILabel!
    @IBOutlet weak var lblZip: UILabel!
    @IBOutlet weak var btnMap: UIButton! {
        didSet {
            btnMap.roundedCorners()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
