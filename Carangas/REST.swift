//
//  REST.swift
//  Carangas
//
//  Created by Usuário Convidado on 13/03/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import UIKit

class REST {
    //session
    private  static let basePath = "https://carangas.herokuapp.com/cars"
    
    private static let configuration : URLSessionConfiguration = {
       let config = URLSessionConfiguration.default
           config.allowsCellularAccess = false
           config.httpAdditionalHeaders = ["Content-type":"applicatioj/json"]
           config.timeoutIntervalForRequest = 30.0
           config.httpMaximumConnectionsPerHost = 3
       return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    class func loadCars(onComplete:@escaping ([Car]) -> Void){
        
        guard let url = URL(string: basePath) else {
            print("Erro ao montar URL")
            return
        }
        let task  = session.dataTask(with: url) { (data, response , error) in
            
            if error != nil {
                print("Deus erro", error!)
                return
            }
            guard let response = response as?  HTTPURLResponse  else{
                print("REsponde nulo")
                return
            }
            if  response.statusCode != 200 {
                print("Deu Ruim",response.statusCode)
                return
            }
            guard let data = data else {
                print("Dados inválidos")
                return
            }
            
            do{
                let cars = try JSONDecoder().decode([Car].self, from: data)
                onComplete(cars)
                print("total de carro", cars.count)
            }catch{
                print(error)
            }
            
        }
        task.resume()
    }
    class func applyOperation(_ operation:RESTOperation,car: Car, onComplete:@escaping (Bool)->Void){
        let URLString = basePath + "/" + (car._id ?? "")
        var httpMethod: String = ""
        switch operation {
        case .delete:
            httpMethod = "DELETE"
        case .save:
            httpMethod = "POST"
        case .updade:
            httpMethod = "PUT"
        }
        guard let url = URL(string: URLString) else {
            onComplete(false)
            return
        }
        var urlRequest =  URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = try! JSONEncoder().encode(car)
        let task = session.dataTask(with: urlRequest) { (data, _, _) in
            guard let _ = data else {
                onComplete(false)
                return
            }
            onComplete(true)
        }
        task.resume()
    }
}
enum RESTOperation{
    case updade
    case delete
    case save
}

