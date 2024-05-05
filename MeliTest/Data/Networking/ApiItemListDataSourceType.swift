//
//  ApiLoginDataSourceType.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import Combine

protocol ApiItemListDataSourceType {
    func GetItemList(_ searchValue: String) -> AnyPublisher<ResultsDTO, HttpClientError>
}
