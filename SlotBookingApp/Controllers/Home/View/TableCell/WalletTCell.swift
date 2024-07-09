//
//  WalletTCell.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit

class WalletTCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblHours: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
