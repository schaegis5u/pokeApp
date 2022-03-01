//
//  ViewController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 01/03/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var pkmsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pkmsTableView.delegate = self
        self.pkmsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
