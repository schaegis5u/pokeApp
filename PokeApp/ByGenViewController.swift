
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
    
    @IBAction func randomizer(_ sender: Any) {
        PokeApi.getPkdx().done{pkmns in
            self.pkmns = pkmns
            PokeApi.getPkmn(nom: self.pkmns[(Int.random(in: 0...(pkmns.count-1)))]).done{pokemon in
                self.poke = pokemon.name
                self.text.text = pokemon.name.uppercased()
                self.IdViewLabel.text = "No°" + pokemon.id
                if pokemon.sprite_off != "" {
                    let imageUrl:URL = URL(string: pokemon.sprite_off)!
                    let imageData:NSData = NSData(contentsOf: imageUrl)!
                    self.imageView.image = UIImage(data: imageData as Data)
                }
                else {
                    self.imageView.image = UIImage(named: "placeholder")
                }

                self.boutonFiche.isHidden = false
                
            }
        }
    }
    
    @IBAction func toPokedex(_ sender: Any) {
        self.performSegue(withIdentifier: "randomToDetails", sender: Any?.self)
        
    }
                          
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "randomToDetails" {
                if let viewControllerDestination = segue.destination as? PokemonViewController {
                    viewControllerDestination.pkmn = self.poke

                }
            
        
        }
        }
}

