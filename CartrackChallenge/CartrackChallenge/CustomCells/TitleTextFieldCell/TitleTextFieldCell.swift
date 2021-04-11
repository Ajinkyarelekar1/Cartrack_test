//
//  TitleTextFieldCellCell.swift
//  TimeApp
//
//  Created by Ashok Yadav on 06/12/20.
//

import UIKit

class TitleTextFieldCell: BaseTableCell, CustomCellProtocol {
    var cellHeight: CGFloat = 100
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textfield.roundedCorners()
        addEdgeInset()
    }
}
