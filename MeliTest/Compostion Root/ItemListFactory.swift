//
//  ItemListFactory.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

/// `ItemListFactory` es una factoría para crear instancias de la vista de lista de los resultados  (`ItemListView`) junto con su modelo (`ItemListViewModel`).

class ItemListFactory {
    private let httpClient: HttpClient
    
    /// Inicializa una nueva instancia de `ItemListFactory` con un cliente HTTP personalizable. Por defecto, se utiliza `URLSessionHTTPCLient` con un creador de solicitudes y resolutor de errores específicos.
    ///
    /// - Parameters:
    ///   - httpClient: Un cliente HTTP que se utilizará para realizar solicitudes de red.
    init(httpClient: HttpClient = URLSessionHTTPCLient(requestMaker: UrlSessionRequestMaker(),
                                                       errorResolver: URLSessionErrorResolver())) {
        self.httpClient = httpClient
    }
    
    /// Crea y devuelve una instancia de `ItemListView` junto con su modelo (`ItemListViewModel`) y una vista de detalle de los resultados  (`ItemDetailView`).
    ///
    /// - Returns: Una instancia de `ItemListView`.
    func create() -> ItemListView {
        return ItemListView(viewModel: createViewModel(),
                             createItemListDetailView: ItemDetailFactory())
    }
    
    /// Crea y devuelve una instancia de `ItemListViewModel` con casos de uso, proveedor de datos y mapeador de errores específicos.
    ///
    /// - Returns: Una instancia de `ItemListViewModel`.
    func createViewModel() -> ItemListViewModel {
        return ItemListViewModel(getItemListType: createUseCase(),
                                  errorMapper: ItemPresentableErrorMapper())
    }
    
    /// Crea y devuelve una instancia de `GetItemListType` (caso de uso) utilizando un repositorio específico.
    ///
    /// - Returns: Una instancia de `GetItemListType`.
    func createUseCase() -> GetItemListType {
        return GetItem(repository: createRepository())
    }
    
    /// Crea y devuelve una instancia de `ItemRepositoryType` (repositorio) utilizando una fuente de datos específica.
    ///
    /// - Returns: Una instancia de `ItemRepositoryType`.
    func createRepository() -> ItemRepositoryType {
        return ItemListRepository(apiDataSource: createDataSource())
    }
    
    /// Crea y devuelve una instancia de `ApiItemListDataSourceType` (fuente de datos) utilizando un cliente HTTP personalizable.
    ///
    /// - Returns: Una instancia de `ApiItemListDataSourceType`.
    func createDataSource() -> ApiItemListDataSourceType {
        return APIItemListDataSource(httpClient: httpClient)
    }
}
