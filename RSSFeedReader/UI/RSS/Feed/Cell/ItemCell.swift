//
//  ItemCell.swift
//  RSSFeedReader
//
//  Created by Munara on 5/5/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    var viewModel: ItemCellViewModel? {
        didSet {
            setup()
        }
    }
    
    class var reuseIdentifier: String {
        return "ItemCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setup() {
        titleLabel.text = viewModel?.getTitle() ?? ""
//        descriptionLabel.text = viewModel?.getDescription() ?? ""
    }
}
