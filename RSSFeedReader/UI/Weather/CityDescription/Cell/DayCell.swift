//
//  DayCell.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class DayCell: UITableViewCell {
    class var reuseIdentifier: String {
           return "DayCell"
       }
    @IBOutlet weak var tempLabel: UILabel!
}
