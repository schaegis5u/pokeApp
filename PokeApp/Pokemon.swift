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

    init(name:String, id:String, sprite:String) {
        self.name = name
        self.id = id
        self.sprite = sprite
        
    }
    
    func selfPresentation(){
        print("[\(self.id)] Pokémon : \(self.name) | \(self.sprite) ")
    }
    
}

