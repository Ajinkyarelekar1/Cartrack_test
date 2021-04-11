//
//  BaseTableCell.swift
//  TimeApp
//
//  Created by Ashok Yadav on 06/12/20.
//

import UIKit

protocol CustomCellProtocol {
    var cellHeight: CGFloat { get }
}

class BaseTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func addEdgeInset() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: padding)
    }
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    class func cellIdentifier() -> String {
        String(describing: self)
    }
}
