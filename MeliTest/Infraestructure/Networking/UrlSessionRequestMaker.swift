//
//  UrlSessionRequestMaker.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

class UrlSessionRequestMaker {
    func url(endpoint: Endpoint, baseUrl: String) -> URL? {
        var urlComponents = URLComponents(string: baseUrl + endpoint.path)
        let urlQueryParameters = endpoint.queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
        urlComponents?.queryItems = urlQueryParameters
        return urlComponents?.url
    }
    
    func urlRequest(endpoint: Endpoint, baseUrl: String) -> URLRequest? {
        let url = URL(string: baseUrl + endpoint.path)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = endpoint.method.getValue()
        request.httpBody = endpoint.queryParameters.percentEncoded()
        return request
    }
}
