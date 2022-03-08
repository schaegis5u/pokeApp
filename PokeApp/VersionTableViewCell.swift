//
//  VersionTableViewCell.swift
//  PokeApp
//
//  Created by Aurelien Schaegis on 08/03/2022.
//

import UIKit

class VersionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ImageVersion: UIImageView!
    
    @IBOutlet weak var LabelVersion: UILabel!

    @IBOutlet weak var whiteView: UIView!
    
   override func awakeFromNib() {

      super.awakeFromNib()
       addShadow()

      // Initialization code

   }

   override func setSelected(_ selected: Bool, animated: Bool) {

      super.setSelected(selected, animated: animated)


      // Configure the view for the selected state

   }
    
    func configure(image: String, title: String) {

        ImageVersion.image = UIImage(named: image)
        LabelVersion.text = title


    }
    
    private func addShadow() {

       whiteView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor

       whiteView.layer.shadowRadius = 2.0

       whiteView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)

       whiteView.layer.shadowOpacity = 2.0
     
    }

}
