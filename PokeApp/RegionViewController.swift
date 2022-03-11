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
    var name: String?
    var pkmns: [String] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var LabelChargement: UILabel!
    @IBOutlet weak var NomVersion: UILabel!
    @IBOutlet weak var ImageRegion: UIImageView!
    @IBOutlet weak var ShadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LabelChargement.isHidden = false
            
            
    
        if let region = region {
            PokeApi.getVersionName(version: region).done{name in
                self.NomVersion.text = name.uppercased()
                self.ImageRegion.image = UIImage(named: name)
            }
            
            PokeApi.getPokemonByVersion(version: String(region)).done{pokemons in
                self.pkmns = pokemons
                self.tableView.reloadData()
                self.LabelChargement.isHidden = true
                self.addShadow()

            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         PokeApi.getPkmnVersion(nom: pkmns[indexPath.row]).done{pokemon in
            self.performSegue(withIdentifier: "tableToDetails2", sender: pokemon.name)
        }
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableToDetails2" {
            
            let pokemon = sender as? String
            
            if let viewControllerDestination = segue.destination as? PokemonViewController {
                viewControllerDestination.pkmn = pokemon!
            }
            
        }
    }
    
    private func addShadow() {

       ShadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor

       ShadowView.layer.shadowRadius = 2.0

       ShadowView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)

       ShadowView.layer.shadowOpacity = 2.0
     
    }
        
}

extension RegionViewController: UITableViewDataSource,UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pkmns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SecondPokemonTableCell")
            PokeApi.getPkmnVersion(nom: pkmns[indexPath.row]).done{pokemon in
                cell.textLabel?.text = "No°" + pokemon.id + " | " + pokemon.name.uppercased()
            }
    
        return cell
    }

    
    
    
}



