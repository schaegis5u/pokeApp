//
//  Pokemon.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import Foundation

class Pokemon {
    
    let name: String
    

    init(name:String) {
        self.name = name
    }
    
    func selfPresentation(){
        print("Pokémon : \(self.name)")
    }
    
}

