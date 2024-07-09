//
//  LoginViewModel.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import Foundation

final class LoginViewModel{
    
    var loginSuccess: ((LoginModel) -> Void)?
    var loginFailure: ((Error) -> Void)?// data binding through closure
    func fetchProducts(email:String, password:String){
        ApiManager.shared.loginApi(email: email, password: password, completion: { respons in
            switch respons {
            case.success(let data):
                self.loginSuccess?(data)
            case.failure(let error):
                self.loginFailure?(error)
            }
        })
    }
}
