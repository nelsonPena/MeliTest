//
//  ItemRepositoryType.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import Combine

protocol ItemRepositoryType {
    func getItem(with searchValue: String) -> AnyPublisher<Results, DomainError>
}
