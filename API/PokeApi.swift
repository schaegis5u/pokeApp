//
//  PokeApi.swift
//  PokeApp

import Alamofire
import SwiftyJSON
import PromiseKit

class PokeApi {
    
    static func getPkdx() -> Promise<[Pokemon]> {
        var pkmns: [Pokemon] = []
        
        return Promise { seal in
            
            AF.request("https://pokeapi.co/api/v2/pokemon?limit=1126").response { response in
                
                if let data = response.data{
                    let dataJson = JSON(data)
                    let tabpkmns = dataJson.arrayValue
                    
                    for pokemon in tabpkmns {
                        
                        pkmns.append(Beer(name: biere["name"].stringValue, degree: biere["abv"].stringValue, description: biere["description"].stringValue, pictureUrl: biere["image_url"].stringValue))
                    }
                
                    seal.fulfill(beers)
                }
            }
        }
    }
}
