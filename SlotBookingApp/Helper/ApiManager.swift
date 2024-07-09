//
//  ApiManager.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import Foundation

final class ApiManager {
    
    static let shared = ApiManager()
    typealias handler = (Result<[ProductsModel],ErrorCondition>)-> Void
    typealias loginHandler = (Result<LoginModel, ErrorCondition>) -> Void
    
    func fetchProducts(competion:@escaping handler){
        guard let url = URL(string: BaseUrl.shared.productUrl)else{ return }
        //URLSession - build connection with server
        //dataTask - give data from url
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data,error == nil else {
                competion(.failure(.invalidResponse))
                return}
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                competion(.failure(.invalidResponse))
                return }
            
            //JSONDecoder
            do{
                let product = try JSONDecoder().decode([ProductsModel].self, from: data)
                competion(.success(product))
            }catch{
                competion(.failure(.network(error)))
            }
            
        }.resume()
        
    }
    
    
    
    //MARK: Login API
    func loginApi(email: String, password: String, completion: @escaping loginHandler) {
        guard let url = URL(string: BaseUrl.shared.loginUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let accessToken = "BearereySllEaTRmSnhsNlRibkY5S2NSa0FqTkwyWE84UC9ObE1iam9nbi9BM1BCdz0="
        let params = [
            "username": email,
            "password": password,
            "expiresInMins": 30,
        ] as [String: Any]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(.failure(.decodingError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.network(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let postModel = try decoder.decode(LoginModel.self, from: data)
                completion(.success(postModel))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}


enum ErrorCondition:Error{
    case invalidResponse
    case invalidUrl
    case decodingError
    case network(Error?)
}
