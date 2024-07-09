//
//  BookingTCell.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit

class BookingTCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblHours: UILabel!
    
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    
    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var btnView: UIView!
    
    @IBOutlet weak var backgroundVw: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAccept.layer.cornerRadius = btnAccept.frame.height / 2
        
        btnReject.layer.cornerRadius = btnReject.frame.height / 2
        
        backgroundVw.layer.cornerRadius = 15
        backgroundVw.layer.masksToBounds = false

        backgroundVw.layer.shadowColor = UIColor.link.cgColor
        backgroundVw.layer.shadowOffset = CGSize(width: 1, height: 1)
        backgroundVw.layer.shadowOpacity = 0.2
        backgroundVw.layer.shadowRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
