//
//  ViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var pkmsTableView: UITableView!
    var pkmns: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeApi.getPkdx().done{pkmns in
            self.pkmns = pkmns
            self.pkmsTableView.reloadData()

        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pkmns[indexPath.row]
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

extension HomeViewController: UITableViewDataSource {
    
    
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

