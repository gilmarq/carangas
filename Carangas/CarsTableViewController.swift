//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2018 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    var cars: [Car] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //[weak self] referencia freca para nao deixa na memoria
        REST.loadCars { [weak self] (loadeCars) in
           // guard let self = self else {return}  so para exibir
            self?.cars = loadeCars
            //para execultar na main theard  que e a theard principal para elementos visuais 
            DispatchQueue.main.async {
                 self?.tableView.reloadData()
            }
           
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let car  = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }
}
