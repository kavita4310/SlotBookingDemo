//
//  AlertController.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit


extension UIViewController{
    func displayAlert(title:String, msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async{
            self.present(alert, animated: true)
        }
    }
}
