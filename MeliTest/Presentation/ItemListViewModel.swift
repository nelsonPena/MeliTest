//
//  ItemListViewModel.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import UIKit
import Combine

/// ViewModel responsable de gestionar la lógica y los datos de la vista de lista de los resultados.
class ItemListViewModel: ObservableObject {
    
    /// Tipo que proporciona acceso a las operaciones relacionadas con la obtención.
    private let getItemListType: GetItemListType
    
    /// Mapeador de errores específico de la vista de lista de los resultados.
    private let errorMapper: ItemPresentableErrorMapper
    
    /// Conjunto de suscripciones a cambios de datos.
    private var cancellables = Set<AnyCancellable>()
    
    /// Lista de los resultados que se muestra en la vista.
    @Published var itemList: [ItemListPresentableItem] = []
    
    /// Indica si se debe mostrar el indicador de carga.
    @Published var showLoadingSpinner: Bool = false
    
    /// Mensaje de error que se muestra en caso de problemas.
    @Published var showErrorMessage: String?
    
    /// Mensaje de carga personalizado.
    @Published var loaderMensaje: String = ""
    
    /// Variable de búsqueda por texto.
    @Published var searchText = ""
    
    
    init(getItemListType: GetItemListType,
         errorMapper: ItemPresentableErrorMapper) {
        self.getItemListType = getItemListType
        self.errorMapper = errorMapper
        setup()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    /// Configura la vista y carga la lista de los resultados.
    func setup() {
        showErrorMessage = nil
        loaderMensaje = "loading_records".localized
        searchItemsInServer()
    }
    
    /// Maneja los errores generados durante la obtención o eliminación de los resultados.
    /// - Parameter error: El error que se ha producido.
    private func handleError(error: DomainError?) {
        showLoadingSpinner = false
        showErrorMessage = errorMapper.map(error: error)
    }
}

//MARK: Obtener data red

extension ItemListViewModel {
    
    /// Obtiene la lista de resultados del servidor y actualiza la vista.
    func searchItemsInServer(searchText: String = "") {
        showLoadingSpinner = true
        getItemListType.getItems(
            with: searchText.isEmpty ? "text_default_search".localized : searchText
        ).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }, receiveValue: { [weak self] item in
                guard let self = self else { return }
                let itemPresentable = item.results.map {
                    return ItemListPresentableItem(domainModel: $0)
                }
                self.itemList = itemPresentable
                self.showLoadingSpinner = false
            })
            .store(in: &cancellables)
    }
}

