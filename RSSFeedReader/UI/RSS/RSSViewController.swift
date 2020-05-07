//
//  ViewController.swift
//  RSSFeedReader
//
//  Created by Munara on 5/5/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import UIKit

class RSSViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    var viewModel: RSSViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchFeeds()
    }
    
    @IBAction func addFeedButtonTapped(_ sender: Any) {
        showAlert()
    }
    func showAlert() {
        let alertController = UIAlertController(title: "Add New Feed", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
               textField.placeholder = "Enter Name"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Link"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            if let name = alertController.textFields?[0].text,
                let link = alertController.textFields?[1].text {
                if name != "" && link != "" && link.isValidURL {
                    self.viewModel?.addFeed(name: name, link: link )
                }
            }
           })
        let cancelAction = UIAlertAction(title: "Cancel", style:.default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension RSSViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getFeedsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseIdentifier,
                                                       for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = viewModel?.getFeed(with: indexPath.row) ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showFeed(with: indexPath.row)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteFeed(with: indexPath)
        }
    }
}
extension RSSViewController: RSSDisplayDelegate {
    func updateTableView() {
        feedTableView.reloadData()
    }
    func deleteTableViewRow(with indexPath: IndexPath) {
        feedTableView.deleteRows(at: [indexPath], with: .fade)
    }
}

