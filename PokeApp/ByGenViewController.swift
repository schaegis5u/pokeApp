
//
//  ByGenViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import UIKit

class ByGenViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var pkmsTableView: UITableView!
    var pkmns: [String] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        

        
        
        self.pkmsTableView.delegate = self
        self.pkmsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension ByGenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pkmns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "PokemonTableCell")

        

    
        return cell
    }
    
    
    
}
