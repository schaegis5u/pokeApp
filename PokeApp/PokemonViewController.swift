//
//  PokemonViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 05/03/2022.
//

import Foundation
import UIKit

class PokemonViewController:UIViewController {
    
    var pkmn: String?
    @IBOutlet weak var nomPoke: UILabel!
    @IBOutlet weak var imagePoke: UIImageView!
    @IBOutlet weak var hpBar: UIProgressView!
    @IBOutlet weak var atkBar: UIProgressView!
    @IBOutlet weak var defBar: UIProgressView!
    @IBOutlet weak var spatkBar: UIProgressView!
    @IBOutlet weak var spdefBar: UIProgressView!
    @IBOutlet weak var spdBar: UIProgressView!
    @IBOutlet weak var sprite_shiny: UIImageView!
    @IBOutlet weak var sprite: UIImageView!
    @IBOutlet weak var type1: UIImageView!
    @IBOutlet weak var type2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pkmn = pkmn {
            self.nomPoke.text = pkmn.uppercased()
            PokeApi.getPkmnInfo(nom: pkmn).done{data in
                let imageUrl:URL = URL(string: data["sprites"]["other"]["official-artwork"]["front_default"].stringValue)!
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData:NSData = NSData(contentsOf: imageUrl)!
                        DispatchQueue.main.async {
                            self.imagePoke.image = UIImage(data: imageData as Data)
                        }
                }
                print(data["stats"][0]["base_stat"].stringValue)
                self.hpBar.progress = ((data["stats"][0]["base_stat"].floatValue) / 255)
                self.atkBar.progress = ((data["stats"][1]["base_stat"].floatValue) / 255)
                self.defBar.progress = ((data["stats"][2]["base_stat"].floatValue) / 255)
                self.spatkBar.progress = ((data["stats"][3]["base_stat"].floatValue) / 255)
                self.spdefBar.progress = ((data["stats"][4]["base_stat"].floatValue) / 255)
                self.spdBar.progress = ((data["stats"][5]["base_stat"].floatValue) / 255)
                let image2Url:URL = URL(string: data["sprites"]["front_default"].stringValue)!
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData2:NSData = NSData(contentsOf: image2Url)!
                        DispatchQueue.main.async {
                            self.sprite.image = UIImage(data: imageData2 as Data)
                        }
                }
                let image3Url:URL = URL(string: data["sprites"]["front_shiny"].stringValue)!
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData3:NSData = NSData(contentsOf: image3Url)!
                        DispatchQueue.main.async {
                            self.sprite_shiny.image = UIImage(data: imageData3 as Data)
                        }
                }
            
                self.type1.image = UIImage(named:data["types"][0]["type"]["name"].stringValue)
                if (data["types"][1]["type"]["name"]).exists(){
                    self.type2.image = UIImage(named: data["types"][1]["type"]["name"].stringValue)
                }
            }
        }
    }
}
