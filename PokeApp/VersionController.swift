//
//  VersionController.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 08/03/2022.
//

import Foundation
import UIKit

class VersionController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableVersion: UITableView!
    
    var versions: [String] = []
    var region: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeApi.getVersion().done{version in
            self.versions = version
            self.tableVersion.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        region = indexPath.row+1
 
        self.performSegue(withIdentifier: "regionToDetails", sender: indexPath.row+1)
   }
    
}
    
    extension VersionController: UITableViewDataSource,UISearchBarDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.versions.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VersionCell", for: indexPath) as? VersionTableViewCell else {

               return UITableViewCell()

            }
            
            PokeApi.getVersionName(version: indexPath.row+1).done{version in
                cell.configure(image: version.lowercased(), title: version.uppercased())
            }

           return cell
           
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "regionToDetails" {
                
                let region = sender as? String
                
                if let viewControllerDestination = segue.destination as? RegionViewController {
                    viewControllerDestination.region = self.region
                }
                
            }
        }
    }


