//
//  RegionViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 08/03/2022.
//

import Foundation
import UIKit

class RegionViewController: UIViewController, UITableViewDelegate {
    var region: Int?
    var pkmns: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let region = region {
            PokeApi.getPokemonByVersion(version: String(region)).done{pokemons in
                self.pkmns = pokemons
                self.tableView.reloadData()

            }
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pkmns[indexPath.row]
        self.performSegue(withIdentifier: "tableToDetails", sender: pokemon)
   }
}
}

extension RegionViewController: UITableViewDataSource,UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pkmns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "PokemonTableCell")
            PokeApi.getPkmn(nom: pkmns[indexPath.row]).done{pokemon in
                cell.textLabel?.text = "No°" + pokemon.id + " | " + pokemon.name.uppercased()
            }
    
        return cell
    }

    
    
    
}



