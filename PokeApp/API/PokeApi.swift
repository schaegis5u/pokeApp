//
//  PokeApi.swift
//  PokeApp

import Alamofire
import SwiftyJSON
import PromiseKit
import Combine

class PokeApi {
    
    static func getPkdx() -> Promise<[String]> {
        var pkmns: [String] = []
        
        return Promise { seal in
            //1126
            AF.request("https://pokeapi.co/api/v2/pokemon?limit=898").response { response in
                
                if let data = response.data{
                    let dataJson = JSON(data)
                    //let tabpkmns = dataJson.arrayValue
                    let tab = dataJson["results"].arrayValue
                    for poke in tab {
                        pkmns.append(poke["name"].stringValue)
                    }
                    
                    
                
                    seal.fulfill(pkmns)
                }
            }
    }
    }
        
    
    static func getPkmn(nom: String) -> Promise<Pokemon> {
        return Promise { seal in
            
            AF.request("https://pokeapi.co/api/v2/pokemon/" + nom).response { response in
                
                if let data = response.data{
                    let dataJson = JSON(data)
                    var sprite = dataJson["sprites"]["front_shiny"].stringValue
                    var sprite_off = dataJson["sprites"]["other"]["official-artwork"]["front_default"].stringValue
                    var id = dataJson["id"].stringValue
            
                    seal.fulfill(Pokemon(name: nom, id:id, sprite:sprite, sprite_off: sprite_off))
                }
            }
        }
    }
}
    
