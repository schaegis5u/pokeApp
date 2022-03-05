//
//  PokemonViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 05/03/2022.
//

import Foundation
import UIKit

class PokemonViewController: UIViewController{
    
    @IBOutlet weak var Type1: UIImageView!
    @IBOutlet weak var Type2: UIImageView!
    @IBOutlet weak var NomPokemon: UILabel!
    @IBOutlet weak var ImagePokemon: UIImageView!
    
    @IBOutlet weak var HP: UIProgressView!
    @IBOutlet weak var ATK: UIProgressView!
    @IBOutlet weak var DEF: UIProgressView!
    @IBOutlet weak var SPATK: UIProgressView!
    @IBOutlet weak var SPDEF: UIProgressView!
    @IBOutlet weak var SPD: UIProgressView!
    
    @IBOutlet weak var SpritePokemon: UIImageView!
    @IBOutlet weak var SpriteShinyPokemon: UIImageView!
    
    public var pkmn: String
    
        // initialisation d'une vue à la volé
    init(frame: CGRect, pokemon: String) {
        self.pkmn = pokemon
        super.init(nibName: nil, bundle: nil)
        
        /*self.title = self.pokemon.name
        self.view = UIView(frame: frame)*/
    }
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


