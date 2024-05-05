//
//  APIItemListDataSource.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import Combine

class APIItemListDataSource: ApiItemListDataSourceType {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func GetItemList(_ searchValue: String) -> AnyPublisher<ResultsDTO, HttpClientError> {
        let endpoint = Endpoint(path: "search",
                                queryParameters: ["q": searchValue.replacingOccurrences(of: " ", with: "%20")],
                                method: .get)
        return httpClient.makeRequest(endpoint: endpoint, baseUrl: Bundle.main.infoDictionary?["BaseUrl"] as? String ?? "")
    }
}
