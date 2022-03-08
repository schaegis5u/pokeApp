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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeApi.getVersion().done{version in
            self.versions = version
            self.tableVersion.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let version = versions[indexPath.row]
        //self.performSegue(withIdentifier: "tableToVersion", sender: version)
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
        /*
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "VersionTableCell")
            PokeApi.getVersionName(version: indexPath.row).done{version in
                cell.textLabel?.text = version.uppercased()
                
            }
            return cell
            
        }
         */
        
        
    }


