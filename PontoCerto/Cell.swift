//
//  Cell.swift
//  PontoCerto
//
//  Created by Leonardo on 05/07/17.
//  Copyright © 2017 Leonardo Santos. All rights reserved.
//

import UIKit

class Cell : UITableViewCell
{
    
    @IBOutlet weak var disciplinaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
