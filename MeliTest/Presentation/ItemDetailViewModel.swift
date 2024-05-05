//
//  ItemDetailViewModel.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import Combine
import CoreData

/// `ItemDetailViewModel` es un ViewModel observable que maneja la lógica relacionada con la eliminación de los resultados  y la gestión de la interfaz de usuario para la vista de detalles de los resultados .

class ItemDetailViewModel: ObservableObject {
    
    /// Una propiedad publicada que indica si se debe mostrar un indicador de carga.
    @Published var showLoadingSpinner: Bool = false
    
    /// Una propiedad publicada que indica si se debe regresar a la vista anterior.
    @Published var goBack: Bool = false
    
    
    /// El objeto `ItemListPresentableItem` que representa los detalles de el personaje
    let ItemDetailPresentable: ItemListPresentableItem
    
    /// Inicializa una nueva instancia de `ItemDetailViewModel`.
    ///
    /// - Parameters:
    ///   - GetItemListType: Un objeto que implementa `GetItemListType` .
    ///   - dataProvider: Un objeto `DataProvider` que gestiona las los resultados en cache.
    ///   - ItemDetailPresentable: El objeto `ItemListPresentableItem` que representa los detalles de el personaje.
    ///   - errorMapper: Un mapeador que se utiliza para transformar errores en mensajes de error legibles.
    init(ItemDetailPresentable: ItemListPresentableItem) {
        self.ItemDetailPresentable = ItemDetailPresentable
    }
}
