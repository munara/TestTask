//
//  CityViewController.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var viewModel: CityViewModel?
    
    @IBOutlet weak var daysTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchTemps()
        cityLabel.text = viewModel?.getCityName() ?? ""
    }
}
extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.reuseIdentifier, for: indexPath) as? DayCell else {
            fatalError("DayCell not found")
        }
        cell.tempLabel.text = viewModel?.getTemp(index: indexPath.row) ?? ""
        return cell
    }
    
}
extension CityViewController: CityDisplayDelegate {
    func updateData() {
        self.daysTableView.reloadData()
    }
    
    
}
