//
//  ProteinTableViewCell.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 25/06/2021.
//

import UIKit

class ProteinTableViewCell: UITableViewCell {
    @IBOutlet weak var ligandName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name:String){
        ligandName.text = name
        activityIndicator.stopAnimating()
    }

}
