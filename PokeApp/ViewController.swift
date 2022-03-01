//
//  ViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // --- DataSource --
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    
    // nombre de section dans la tableView (obligatoire)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // nombre de ligne dans la section (obligatoire)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }
    
    // déclaration de le cellule (obligatoire)
    // ici on utilise le format de cellule par default
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "PokemonTableViewCell")
        
        let index = (pokemons.count/sectionsNum)*indexPath.section
        print("Index : " + String(index))
        let pokemon = pokemons[(indexPath.row + index)]
        cell.textLabel?.text = pokemon.name
        
        
        return cell
    }
    
    // --- Delegate ---
    
    // cette fonction décrit la logique appliquer une fois qu'on clic sur une cellule
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        let viewController = PokemonViewController(frame: tableView.frame, pokemon: pokemon)
        
        navigationController?.pushViewController(viewController, animated: true)
    }


}

