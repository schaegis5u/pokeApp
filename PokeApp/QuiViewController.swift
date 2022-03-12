//
//  QuiViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 11/03/2022.
//

import Foundation
import UIKit

class QuiViewController: UIViewController {
    
    
    @IBOutlet weak var ImagePokemon: UIImageView!
    
    @IBOutlet weak var Pokemon1: UIButton!
    @IBOutlet weak var Pokemon2: UIButton!
    @IBOutlet weak var Pokemon3: UIButton!
    @IBOutlet weak var Pokemon4: UIButton!
    
    @IBOutlet weak var LabelResult: UILabel!
    
    @IBOutlet weak var RetryButton: UIButton!
    
    @IBOutlet weak var score: UILabel!
    //var GameState:Bool = false
    
    
    var Pokemons:[String] = []
    
    var selectedPokemon:Pokemon?
    
    var scoreNumber:Int = 0
    
    override func viewDidLoad() {
        score.text = "0"
        super.viewDidLoad()
        self.RetryButton.isHidden = true
        self.Pokemon1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        self.Pokemon2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        self.Pokemon3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        self.Pokemon4.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        self.loadGame()

        
    }
    
    
    
    @IBAction func retryButtonAction(_ sender: Any) {
        self.loadGame()
        RetryButton.isHidden = true
        LabelResult.text = ""
        Pokemon1.isEnabled = true
        Pokemon2.isEnabled = true
        Pokemon3.isEnabled = true
        Pokemon4.isEnabled = true

    }
    
    @IBAction func pkmn1action(_ sender: Any) {
        if(self.Pokemon1.currentTitle?.lowercased() == selectedPokemon?.name){
            self.endGameStateWin()
        }
        else{
            endGameStateLose()
        }
    }
    
    @IBAction func pkmn2action(_ sender: Any) {
        if(self.Pokemon2.currentTitle?.lowercased() == selectedPokemon?.name){
            self.endGameStateWin()
        }
        else{
            endGameStateLose()
        }
    }
    
    @IBAction func pkmn3action(_ sender: Any) {
        if(self.Pokemon3.currentTitle?.lowercased() == selectedPokemon?.name){
            self.endGameStateWin()
        }
        else{
            endGameStateLose()
        }
    }
    
    @IBAction func pkmn4action(_ sender: Any) {
        if(self.Pokemon4.currentTitle?.lowercased() == selectedPokemon?.name){
            self.endGameStateWin()
        }
        else{
            endGameStateLose()
        }
    }
    
    
    private func endGameStateWin(){
        scoreNumber = scoreNumber + 1
        RetryButton.isHidden = false
        LabelResult.text = "Well done !"
        score.text = "Score : "+String(scoreNumber)
        Pokemon1.isEnabled = false
        Pokemon2.isEnabled = false
        Pokemon3.isEnabled = false
        Pokemon4.isEnabled = false
    }
    
    private func endGameStateLose(){
        scoreNumber = scoreNumber - 1
        score.text = "Score : "+String(scoreNumber)
        RetryButton.isHidden = false
        LabelResult.text = "Try again, the Pokémon was "+(selectedPokemon?.name.uppercased())!
        Pokemon1.isEnabled = false
        Pokemon2.isEnabled = false
        Pokemon3.isEnabled = false
        Pokemon4.isEnabled = false
    }
    
    private func loadGame(){
        self.Pokemons.removeAll()
        PokeApi.getRandomPkmns(nb: 3).done{poke in
            self.Pokemons = poke
            
            self.Pokemon1.setTitle(self.Pokemons[0].uppercased(), for: .normal)
            self.Pokemon2.setTitle(self.Pokemons[1].uppercased(), for: .normal)
            self.Pokemon3.setTitle(self.Pokemons[2].uppercased(), for: .normal)
            self.Pokemon4.setTitle(self.Pokemons[3].uppercased(), for: .normal)
            
            
            PokeApi.getPkmn(nom: self.Pokemons[Int.random(in: 0..<4)]).done{poke in
                self.selectedPokemon = poke
                if self.selectedPokemon!.sprite_off != ""{
                    let imageUrl:URL = URL(string: self.selectedPokemon!.sprite_off)!
                    let imageData:NSData = NSData(contentsOf: imageUrl)!
                    self.ImagePokemon.image = UIImage(data: imageData as Data)
                }
                else {
                    self.loadGame()
                }
                
            }
            
            
        }
        
        
        
    }
    
}
