//
//  DetTableViewCell.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/7/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import UIKit

class DetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detTextLabel: UILabel!
    @IBOutlet weak var detImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
