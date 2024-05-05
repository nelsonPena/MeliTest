//
//  GetItem.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import UIKit
import Combine


/// `GetItem` es una clase de la capa de dominio que implementa el protocolo `GetItemListType` para obtener  los resultados .

class GetItem {
    private let repository: ItemRepositoryType
    
    /// Inicializa una nueva instancia de `GetItem` con un repositorio personalizado.
    ///
    /// - Parameters:
    ///   - repository: El repositorio que se utilizará para obtener  los resultados .
    init(repository: ItemRepositoryType) {
        self.repository = repository
    }
}

extension GetItem: GetItemListType {
    
    /// Obtiene una lista de los resultados  utilizando el repositorio y emite un editor de AnyPublisher que puede contener una lista de los resultados  o un error de `DomainError`.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una lista de los resultados  o un error de `DomainError`.
    func getItems(with searchValue: String) ->  AnyPublisher<Results, DomainError> {
        repository.getItem(with: searchValue)
    }
}
