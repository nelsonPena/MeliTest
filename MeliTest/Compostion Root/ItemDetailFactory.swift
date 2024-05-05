//
//  ItemDetailFactory.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import SwiftUI

/// `ItemDetailFactory` es una factoría para crear instancias de la vista de detalles de los resultados  (`ItemDetailView`) junto con su modelo (`ItemDetailViewModel`).

class ItemDetailFactory: CreateItemListDetailView {
    
    /// Crea y devuelve una instancia de `ItemDetailView` con los datos de vista proporcionados.
    ///
    /// - Parameters:
    ///   - viewData: Los datos de vista que se utilizarán para configurar la vista de detalles.
    ///
    /// - Returns: Una instancia de `ItemDetailView`.
    func create(with viewData: ItemListPresentableItem) -> ItemDetailView {
        return ItemDetailView(viewModel: createViewModel(viewData: viewData),
                               viewData: viewData)
    }
    
    /// Crea y devuelve una instancia de `ItemDetailViewModel` con los datos de vista proporcionados.
    ///
    /// - Parameters:
    ///   - viewData: Los datos de vista que se utilizarán para configurar el modelo de detalles.
    ///
    /// - Returns: Una instancia de `ItemDetailViewModel`.
    private func createViewModel(viewData: ItemListPresentableItem) -> ItemDetailViewModel {
        return ItemDetailViewModel(ItemDetailPresentable: viewData)
    }
    
    /// Crea y devuelve una instancia de `GetItemListType` (caso de uso) utilizando un repositorio y fuente de datos específicos.
    ///
    /// - Returns: Una instancia de `GetItemListType`.
    private func createUseCase() -> GetItemListType {
        return GetItem(repository: createRepository())
    }
    
    /// Crea y devuelve una instancia de `ItemRepositoryType` (repositorio) utilizando una fuente de datos específica.
    ///
    /// - Returns: Una instancia de `ItemRepositoryType`.
    private func createRepository() -> ItemRepositoryType {
        return ItemListRepository(apiDataSource: createDataSource())
    }
    
    /// Crea y devuelve una instancia de `ApiItemListDataSourceType` (fuente de datos) utilizando un cliente HTTP específico.
    ///
    /// - Returns: Una instancia de `ApiItemListDataSourceType`.
    private func createDataSource() -> ApiItemListDataSourceType {
        return APIItemListDataSource(httpClient: createHTTPClient())
    }
    
    /// Crea y devuelve una instancia de `HttpClient` (cliente HTTP) utilizando un creador de solicitudes y resolutor de errores específicos.
    ///
    /// - Returns: Una instancia de `HttpClient`.
    private func createHTTPClient() -> HttpClient {
        return URLSessionHTTPCLient(requestMaker: UrlSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
