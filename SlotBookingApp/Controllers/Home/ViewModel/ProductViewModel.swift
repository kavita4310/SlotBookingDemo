//
//  ProductViewModel.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import Foundation


final class ProductViewModel{
    
    var productSuccess: (([ProductsModel]) -> Void)?
    var productFailure: ((Error) -> Void)?// data binding through closure
    func fetchProducts(){
        ApiManager.shared.fetchProducts { response in
            switch response{
            case.success(let product):
                self.productSuccess?(product)
                
            case.failure(let error):
                self.productFailure?(error)
                
            }
        }
    }
}
