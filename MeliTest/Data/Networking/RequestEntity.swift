//
//  RequestEntity.swift
//  Midi
//
//  Created by Asesoftware on 18/10/23.
//

import Foundation

/// Estructura para representar una solicitud HTTP
struct RequestEntity {

    var baseUrl: String
    var endPoint: String
    var queryParams: [String: String]
    var method: HTTPMethod
    var headers: [String: String]
    var body: [String: Any]?

    /// Método para obtener la URL completa de la solicitud
    public func getRequestURL() -> URL? {
        let params = (self.queryParams.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
        let url = "\(self.baseUrl)\(self.endPoint)?\(params)".dropLast()
        return URL(string: String(url))
    }
}
