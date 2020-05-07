//
//  WeatherViewController.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    var viewModel: WeatherViewModel?
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        viewModel?.fetchWorldCities()
        viewModel?.fetchCurrentCities()
    }
    @IBAction func addMoreButtonTapped(_ sender: Any) {
        showAlert()
    }
    func showAlert() {
        viewModel?.isCitySelected = false
        let alertController = UIAlertController(title: "Add New City", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
               textField.placeholder = "Enter City"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            if let name = alertController.textFields?[0].text {
                if name != "" {
                    self.viewModel?.addCity(with: name)
                }
            }
           })
        let cancelAction = UIAlertAction(title: "Cancel", style:.default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifier, for: indexPath) as? CityCell else {
            fatalError("CityCell is not found")
        }
        cell.cityNameLabel.text = viewModel?.getCurrentCityName(by: indexPath.row) ?? ""
        viewModel?.getCurrentCityTemp(by: indexPath.row) { result in
            DispatchQueue.main.async {
                cell.tempLabel.text = result
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteCity(with: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showDescription(index: indexPath.row)
    }
    
    
}
extension WeatherViewController: WeatherDisplayDelegate {
    func deleteTableViewRow(indexPath: IndexPath) {
        citiesTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func updateData() {
        citiesTableView.reloadData()
    }
    
    
}
