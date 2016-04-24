//
//  SenhaCell.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 18/03/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

class SenhaCell: UITableViewCell {

    @IBOutlet weak var nomeSenha: UILabel!
    @IBOutlet weak var resultadoSenha: UILabel!
    @IBOutlet weak var login: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
