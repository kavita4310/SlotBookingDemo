//
//  ProductModel.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import Foundation



struct ProductsModel:Decodable {
    let id:Int
    let title:String
    let price:Float
    let description:String
    let category:String
    let image:String
    let rating:Ratings
}
struct Ratings:Decodable {
    let rate:Float
    let count:Int
}
