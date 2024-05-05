//
//  CreateItemListDetailView.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import SwiftUI

/// `CreateItemListDetailView` es un protocolo que define un método para crear una vista de detalles de los resultados  (`ItemDetailView`) utilizando los datos de vista proporcionados.

protocol CreateItemListDetailView {
    
    /// Crea y devuelve una instancia de `ItemDetailView` utilizando los datos de vista proporcionados.
    ///
    /// - Parameters:
    ///   - viewData: Los datos de vista que se utilizarán para configurar la vista de detalles.
    ///
    /// - Returns: Una instancia de `ItemDetailView`.
    func create(with viewData: ItemListPresentableItem) -> ItemDetailView
}
