//
//  ViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pkmsTableView: UITableView!
    var pkmns: [String] = []
    var pokemonTest: [String] = []
    var pkmnsfiltered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        PokeApi.getPkdx().done{pkmns in
            self.pkmns = pkmns
            self.pkmnsfiltered = pkmns
            self.pkmsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pkmnsfiltered[indexPath.row]
        self.performSegue(withIdentifier: "tableToDetails", sender: pokemon)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableToDetails" {
            
            let pokemon = sender as? String
            
            if let viewControllerDestination = segue.destination as? PokemonViewController {
                viewControllerDestination.pkmn = pokemon!
            }
            
        }
    }
    
    
    
   
}


let navigationController = UINavigationController(rootViewController: HomeViewController())

extension HomeViewController: UITableViewDataSource,UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pkmnsfiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "PokemonTableCell")
            PokeApi.getPkmn(nom: pkmnsfiltered[indexPath.row]).done{pokemon in
                cell.textLabel?.text = "No°" + pokemon.id + " | " + pokemon.name.uppercased()
            }
    
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pkmnsfiltered = searchText.isEmpty ? pkmns : pkmns.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        self.pkmsTableView.reloadData()
    }
    
    
    
    
}

