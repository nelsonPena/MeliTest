//
//  HTTPMethod.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case delete
    
    func getValue() -> String {
        var httpMethod: String
        switch self {
        case .get:
            httpMethod = "GET"
        case .post:
            httpMethod = "POST"
        case .delete:
            httpMethod = "DELETE"
        }
        return httpMethod
    }
}
