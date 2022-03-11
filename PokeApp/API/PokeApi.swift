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
            AF.request("https://pokeapi.co/api/v2/pokemon?limit=1200").response { response in
                
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
                    let sprite = dataJson["sprites"]["front_shiny"].stringValue
                    let sprite_off = dataJson["sprites"]["other"]["official-artwork"]["front_default"].stringValue
                    let id = dataJson["id"].stringValue
            
                    seal.fulfill(Pokemon(name: nom, id:id, sprite:sprite, sprite_off: sprite_off))
                }
            }
        }
    }
    
    static func getPkmnVersion(nom: String) -> Promise<Pokemon> {
        return Promise { seal in
            
            AF.request("https://pokeapi.co/api/v2/pokemon-species/" + nom).response { response in
                
                if let data = response.data{
                    let dataJson = JSON(data)
                    let sprite = ""
                    let sprite_off = ""
                    let id = dataJson["id"].stringValue
                    let name = dataJson["varieties"][0]["pokemon"]["name"].stringValue
            
                    seal.fulfill(Pokemon(name: name, id:id, sprite:sprite, sprite_off: sprite_off))
                }
            }
        }
    }
    
    static func getPkmnInfo(nom: String) -> Promise<JSON> {
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/pokemon/" + nom).response { response in
                if let data = response.data{
                    let dataJson = JSON(data)
                    seal.fulfill(dataJson)
            }
        }
    }
    }
    //Version pas chiante
    /*static func getPokemonByVersion(version: String) -> Promise<[String]> {
        var pkmn: [String] = []
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/generation/"+version).response { response in
                if let data = response.data{
                    let datajson = JSON(data)
                    for i in 0...datajson["pokemon_species"].count{
                        pkmn.append(datajson["pokemon_species"][i]["name"].stringValue)
                    }
                    seal.fulfill(pkmn)
                }
            }
        }
    }*/
    
    
    static func getPokemonByVersion(version: String) -> Promise<[String]> {
        var pkmn: [String] = []
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/generation/"+version).response { response in
                if let data = response.data{
                    let datajson = JSON(data)
                    var min = 0
                    var nb = 0
                    switch version {
                    case "1":
                        min = 1
                        nb = datajson["pokemon_species"].count
                    case "2":
                        //1e entree du pokedex de la gen
                        min = 152
                        //nb de poke dans la gen
                        nb = datajson["pokemon_species"].count
                    case "3":
                        min = 252
                        nb = datajson["pokemon_species"].count
                    case "4":
                        min = 387
                        nb = datajson["pokemon_species"].count
                    case "5":
                        min = 494
                        nb = datajson["pokemon_species"].count
                    case "6":
                        min = 650
                        nb = datajson["pokemon_species"].count
                    case "7":
                        min = 722
                        nb = datajson["pokemon_species"].count
                    case "8":
                        min = 810
                        nb = datajson["pokemon_species"].count
                    default:
                        break
                    }
                    
                    while pkmn.count != nb {
                        for i in 0...datajson["pokemon_species"].count{
                            var num = (datajson["pokemon_species"][i]["url"].stringValue).split(separator: "/")
                            if let id = num.popLast() {
                                if (Int(id)) == (pkmn.count+min){
                                    pkmn.append(datajson["pokemon_species"][i]["name"].stringValue)
                                }
                            }
                        }
                    }
                    seal.fulfill(pkmn)
                }
            }
        }
    }
    
    
    
    static func getVersion() -> Promise<[String]> {
        var versions: [String] = []
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/generation").response { response in
                if let data = response.data{
                    let datajson = JSON(data)
                    
                    let tab = datajson["results"].arrayValue
                    for version in tab {
                        versions.append(version["name"].stringValue)
                    }
                }
                seal.fulfill(versions)

            }
        }
    }
    
    static func getVersionName(version: Int) -> Promise<String> {
        var versionname : String = ""
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/generation/"+String(version)).response { response in
                if let data = response.data{
                    let datajson = JSON(data)
                    
                    versionname = datajson["main_region"]["name"].stringValue
                    }
                    seal.fulfill(versionname)
                }
            }
        }
    
    static func getArea() -> Promise<[String]> {
        var zones: [String] = []
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/location-area?limit=750").response { response in
                if let data = response.data{
                    let datajson = JSON(data)
                    let tab = datajson["results"].arrayValue
                    for zone in tab {
                        zones.append(zone["name"].stringValue)
                    }
                }
                seal.fulfill(zones)
            }
        }
    }
    
    static func getAreaPokemon(nom: String) -> Promise<[String]> {
        var pokemons: [String] = []
        return Promise { seal in
            AF.request("https://pokeapi.co/api/v2/location-area/"+nom).response { response in
                if let data = response.data{
                    let datajson = JSON(data)
                    let tab = datajson["pokemon_encounters"].arrayValue
                    for poke in tab {
                        pokemons.append(poke["pokemon"]["name"].stringValue)
                    }
                }
                seal.fulfill(pokemons)
            }
        }
    }

}

