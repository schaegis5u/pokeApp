//
//  Pokemon.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import Foundation

class Pokemon {
    
    let name: String
    let id: String
    let sprite: String
    let sprite_off: String

    init(name:String, id:String,  sprite:String, sprite_off:String) {
        self.name = name
        self.id = id
        self.sprite = sprite
        self.sprite_off = sprite_off
        
        
    }
    
    func selfPresentation(){
        print("[\(self.id)] Pokémon : \(self.name) ")
    }
    
}

