//
//  FeedCell.swift
//  RSSFeedReader
//
//  Created by Munara on 5/5/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    class var reuseIdentifier: String {
        return "FeedCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
