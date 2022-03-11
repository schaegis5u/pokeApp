//
//  AreaPokemonViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 11/03/2022.
//

import UIKit

class AreaPokemonViewController: UIViewController, UITableViewDelegate {


    var zone: String?
    var pkmns: [String] = []
    @IBOutlet weak var tableViewPoke: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let zone = zone {
            PokeApi.getAreaPokemon(nom: zone).done{pokemons in
                self.pkmns = pokemons
                self.tableViewPoke.reloadData()
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pkmns[indexPath.row]
        self.performSegue(withIdentifier: "PokeAreaToDetails", sender: pokemon)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeAreaToDetails" {
            
            let pokemon = sender as? String
            
            if let viewControllerDestination = segue.destination as? PokemonViewController {
                viewControllerDestination.pkmn = pokemon!
            }
            
        }
    }
    

}


extension AreaPokemonViewController: UITableViewDataSource,UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pkmns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "PokemonAreaTableCell")
            PokeApi.getPkmn(nom: pkmns[indexPath.row]).done{pokemon in
                cell.textLabel?.text = "No°" + pokemon.id + " | " + pokemon.name.uppercased()
            }
    
        return cell
    }
}

