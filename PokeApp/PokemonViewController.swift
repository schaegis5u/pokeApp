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
    @IBOutlet weak var hpLab: UILabel!
    @IBOutlet weak var atkLab: UILabel!
    @IBOutlet weak var defLab: UILabel!
    @IBOutlet weak var spdLab: UILabel!
    @IBOutlet weak var spdefLab: UILabel!
    @IBOutlet weak var spatkLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pkmn = pkmn {
            self.nomPoke.text = pkmn.uppercased()
            PokeApi.getPkmnInfo(nom: pkmn).done{data in
                if data["sprites"]["other"]["official-artwork"]["front_default"].stringValue != "" {
                    let imageUrl:URL = URL(string: data["sprites"]["other"]["official-artwork"]["front_default"].stringValue)!
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData:NSData = NSData(contentsOf: imageUrl)!
                            DispatchQueue.main.async {
                                self.imagePoke.image = UIImage(data: imageData as Data)
                            }
                    }
                }
                self.hpBar.progress = ((data["stats"][0]["base_stat"].floatValue) / 255)
                self.atkBar.progress = ((data["stats"][1]["base_stat"].floatValue) / 255)
                self.defBar.progress = ((data["stats"][2]["base_stat"].floatValue) / 255)
                self.spatkBar.progress = ((data["stats"][3]["base_stat"].floatValue) / 255)
                self.spdefBar.progress = ((data["stats"][4]["base_stat"].floatValue) / 255)
                self.spdBar.progress = ((data["stats"][5]["base_stat"].floatValue) / 255)
                
                self.hpLab.text = (data["stats"][0]["base_stat"].stringValue)
                self.atkLab.text = (data["stats"][1]["base_stat"].stringValue)
                self.defLab.text = (data["stats"][2]["base_stat"].stringValue)
                self.spatkLab.text = (data["stats"][3]["base_stat"].stringValue)
                self.spdefLab.text = (data["stats"][4]["base_stat"].stringValue)
                self.spdLab.text = (data["stats"][5]["base_stat"].stringValue)
                
                if data["sprites"]["front_default"].stringValue != "" {
                    let image2Url:URL = URL(string: data["sprites"]["front_default"].stringValue)!
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData2:NSData = NSData(contentsOf: image2Url)!
                            DispatchQueue.main.async {
                                self.sprite.image = UIImage(data: imageData2 as Data)
                            }
                    }
                }
                if data["sprites"]["front_shiny"].stringValue != "" {
                    let image3Url:URL = URL(string: data["sprites"]["front_shiny"].stringValue)!
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData3:NSData = NSData(contentsOf: image3Url)!
                            DispatchQueue.main.async {
                                self.sprite_shiny.image = UIImage(data: imageData3 as Data)
                            }
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
