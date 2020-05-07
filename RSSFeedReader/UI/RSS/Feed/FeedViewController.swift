//
//  FeedViewController.swift
//  RSSFeedReader
//
//  Created by Munara on 5/5/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel?
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchItems()
    }
}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell else {
            fatalError("ItemCell is not found")
        }
        cell.viewModel = viewModel?.getItemCell(with: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showItemDescription(with: indexPath.row)
    }
    
    
}
extension FeedViewController: FeedDisplayDelegate {
    func updateView() {
        self.newsTableView.reloadData()
    }
    
    
}
