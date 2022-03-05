
//
//  ByGenViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import UIKit

class ByGenViewController: UIViewController {

    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pkmsTableView: UITableView!
    @IBOutlet weak var IdViewLabel: UILabel!
    @IBOutlet weak var bouton: UIButton!
    @IBOutlet weak var boutonFiche: UIButton!
    var pkmns: [String] = []
    var poke : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boutonFiche.isHidden = true
    }
    
    // La fonction est liée au 2 boutons, c'est la merde, corriger
    @IBAction func randomizer(_ sender: Any) {
        boutonFiche.isHidden = false
        PokeApi.getPkdx().done{pkmns in
            self.pkmns = pkmns
            PokeApi.getPkmn(nom: self.pkmns[(Int.random(in: 0...(pkmns.count-1)))]).done{pokemon in
                self.poke = pokemon.name
                self.text.text = pokemon.name.uppercased()
                self.IdViewLabel.text = "No°" + pokemon.id
                let imageUrl:URL = URL(string: pokemon.sprite_off)!
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData:NSData = NSData(contentsOf: imageUrl)!
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: imageData as Data)
                        }
                }
                
            }
        }
    }
    
    @IBAction func toPokedex(_ sender: Any) {
        self.performSegue(withIdentifier: "randomToDetails", sender: poke)
        
    }
                          
    func prepare(for segue: UIStoryboardSegue, sender: String?) {
        if segue.identifier == "randomToDetails" {
            let pokemon = sender as? String

            if let viewControllerDestination = segue.destination as? PokemonViewController {
                viewControllerDestination.pkmn = pokemon!
            }
            
        }
        }
}

