//
//  GetItemListType.swift
//  MeliTest
//
//  Created by Nelson Peña on 2/02/24.
//

import Foundation
import Combine

/// `GetItemListType` es un protocolo de la capa de dominio que define métodos para obtener los resultados.

protocol GetItemListType: AnyObject {
    
    /// Obtiene una lista de los resultados y emite un editor de AnyPublisher que puede contener una lista de los resultados o un error de `DomainError`.
    func getItems(with searchValue: String) -> AnyPublisher<Results, DomainError>
}
