//
//  ZoneViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 11/03/2022.
//

import UIKit

class ZoneViewController: UIViewController, UITableViewDelegate {


    var zones: [String] = []
    var pkmns: [String] = []
    @IBOutlet weak var tableViewArea: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeApi.getArea().done{zones in
            self.zones = zones
            self.tableViewArea.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let area = zones[indexPath.row]
        self.performSegue(withIdentifier: "areaToPokemon", sender: area)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "areaToPokemon" {
            
            let area = sender as? String
            
            if let viewControllerDestination = segue.destination as? AreaPokemonViewController {
                viewControllerDestination.zone = area!
            }
            
        }
    }
    

}


extension ZoneViewController: UITableViewDataSource,UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "AreaTableCell")
        cell.textLabel?.text = zones[indexPath.row].uppercased()
        return cell
    }
}
