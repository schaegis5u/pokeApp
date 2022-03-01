
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
    var pkmns: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        random()
    }
    
    @IBAction func randomizer(_ sender: Any) {
        random()
    }
    func random(){
        PokeApi.getPkdx().done{pkmns in
            self.pkmns = pkmns
            PokeApi.getPkmn(nom: self.pkmns[(Int.random(in: 0...(pkmns.count)))]).done{pokemon in
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
}

