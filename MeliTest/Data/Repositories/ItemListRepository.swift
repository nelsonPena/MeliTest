//
//  ItemListRepository.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import Combine

/// `ItemListRepository` es un repositorio que gestiona la obtención y eliminación de los resultados utilizando un origen de datos de API.

class ItemListRepository: ItemRepositoryType {
    
    private let apiDataSource: ApiItemListDataSourceType
    
    /// Inicializa una nueva instancia de `ItemListRepository` con un origen de datos de API personalizado.
    ///
    /// - Parameter apiDataSource: El origen de datos de API que se utilizará para obtener los resultados.
    init(apiDataSource: ApiItemListDataSourceType) {
        self.apiDataSource = apiDataSource
    }
    
    /// Obtiene una lista de los resultados y las mapea a objetos `Item` utilizando Combine.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una lista de los resultados o un error de `DomainError`.
    func getItem(with searchValue: String) -> AnyPublisher<Results, DomainError> {
        let response: AnyPublisher<ResultsDTO, HttpClientError> = apiDataSource.GetItemList(searchValue)
        return response
            .map { $0.mapper() }
            .mapError { $0.map() }
            .eraseToAnyPublisher()
    }
}
