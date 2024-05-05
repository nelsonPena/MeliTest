//
//  UrlSessionRequestMaker.swift
//  images
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

class UrlSessionRxRequestMaker {
    
    func urlRequest(requestModel: RequestEntity) -> URLRequest? {
        guard let url = requestModel.getRequestURL() else {
            return nil
        }
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 20)
        // HEADERS
        for (key, value) in requestModel.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // METHOD
        request.httpMethod = requestModel.method.getValue()
        // BODY
        if requestModel.body != nil {

            guard let body = requestModel.body else {
                return nil
            }

            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                return nil
            }
            
            request.httpBody = httpBody
        }

        let messageLogs = """
                URL: \(url)
                EndPoint \(requestModel.endPoint)
                Headers \(requestModel.headers)
                Body \(requestModel.body ?? ["": ""])
                """
        print("\(messageLogs)")
        return request
    }
    
}
