//
//  APIRequester.swift
//  NasaPhoto
//
//  Created by bushra on 08/04/21.
//  Copyright © 2021 bushra. All rights reserved.
//

import UIKit

protocol Requestable {
    
    func request() -> URLRequest
}

class APIRequester: NSObject {
    private let method: String
    private let url: String
     
    override init() {
         self.method = "GET"
         self.url = EndPoint().baseUrl
     }
     
     func request() -> URLRequest {
         guard let url = URL(string: self.url) else { preconditionFailure("Convert Error")}
         var request = URLRequest(url: url)
         request.httpMethod = method
         request.addValue("aplication/json", forHTTPHeaderField: "Accept")
         return request
     }
}
