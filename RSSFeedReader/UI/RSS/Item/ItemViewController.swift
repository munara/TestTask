//
//  ItemViewController.swift
//  RSSFeedReader
//
//  Created by Munara on 5/7/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var viewModel: ItemViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        descriptionLabel.text = viewModel?.getDescription() ?? ""
        titleLabel.text = viewModel?.getTitle() ?? ""
    }
}
