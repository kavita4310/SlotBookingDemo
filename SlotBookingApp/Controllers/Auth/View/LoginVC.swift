//
//  LoginVC.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var passwordVw: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    let loginModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
    
    // Configuration
    func configuration(){
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        emailVw.layer.cornerRadius = 10
        emailVw.layer.borderWidth = 1
        emailVw.layer.borderColor = UIColor.lightGray.cgColor
        passwordVw.layer.cornerRadius = 10
        passwordVw.layer.borderWidth = 1
        passwordVw.layer.borderColor = UIColor.lightGray.cgColor
        btnLogin.layer.cornerRadius = btnLogin.frame.height / 2
        
        txtEmail.text = "emilys"
        txtPassword.text = "emilyspass"
        
        if !txtEmail.text!.isEmpty {
            lblEmail.isHidden = false
        }
        if !txtEmail.text!.isEmpty{
            lblPassword.isHidden = false
        }
     
    }
    
    // MARK: Login Api
    func loginApi(){
        loginModel.fetchProducts(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
        loginModel.loginSuccess = { data in
            print(data)
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabbarController") as! CustomTabbarController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        loginModel.loginFailure = { error in
            self.displayAlert(title: "Alert", msg: error.localizedDescription)
        }
    }
    
    // MARK: Textfield Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       if textField == txtEmail{
           lblEmail.isHidden = false
           emailVw.layer.borderColor = UIColor.link.cgColor
       }else {
           lblPassword.isHidden = false
           passwordVw.layer.borderColor = UIColor.link.cgColor
       }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       if textField == txtEmail{
           if txtEmail.text!.isEmpty{
               lblEmail.isHidden = true
               emailVw.layer.borderColor = UIColor.lightGray.cgColor
           }else{
               lblEmail.isHidden = false
               emailVw.layer.borderColor = UIColor.link.cgColor
           }
          
       }else {
           if txtPassword.text!.isEmpty {
               lblPassword.isHidden = true
               passwordVw.layer.borderColor = UIColor.lightGray.cgColor
           }else{
               lblPassword.isHidden = false
               passwordVw.layer.borderColor = UIColor.link.cgColor
           }
          
       }
    }

    // MARK: BtnLogin
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if !txtEmail.text!.isEmpty && !txtPassword.text!.isEmpty{
            loginApi()
        }else{
            self.displayAlert(title: "Alert", msg: "Required all feilds")
        }
        
    }
    


}
