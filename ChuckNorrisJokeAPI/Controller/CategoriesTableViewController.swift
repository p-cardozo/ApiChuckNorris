//
//  CategoryTableViewController.swift
//  ChuckNorrisJokeAPI
//
//  Created by Patricia dos Santos Cardozo on 07/12/20.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CategoriesREST.loadCategories(onComplete: { (category) in
            self.categories = category
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    @IBAction func shuffleButton(_ sender: UIButton) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let category = categories[indexPath.row];
        cell.textLabel?.text = "\(category.uppercased())"
        cell.textLabel?.font = UIFont(name: "Avenir Heavy", size: 16.0)
            tableView.tableFooterView = UIView()
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row];
        TypeString.name = category
    }

}
