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
        
        
       return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    
    
    
    
}
