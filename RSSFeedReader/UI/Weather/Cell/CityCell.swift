//
//  CityCell.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    class var reuseIdentifier: String {
        return "CityCell"
    }
}
