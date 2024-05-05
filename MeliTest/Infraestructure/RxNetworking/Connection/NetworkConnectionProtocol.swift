//
//  Ne.swift
//  OneAppTestV3
//
//  Created by Reinner Daza Leiva on 9/11/22.
//

import Foundation
import Network

/// Protocolo para gestionar la conexión de red
protocol NetworkConnectionProtocol {

     /// Detiene el escaneo de red
    func networkScanStop()
    
    /// Obtiene el estado de la conexión de red
    /// - Returns: `true` si la conexión de red está disponible, `false` en caso contrario.
    func getStatusNetwork() -> Bool

    /// Inicia el escaneo de red
    func networkScanStart()

    /// Configura el monitor de ruta de red
    func configNetworkPathMonitor()
    
    /// Actualiza el tipo de conexión de red
    /// - Parameter path: Ruta de red que contiene información sobre la conexión
    func updateNetworkConnectionType(_ path: NWPath)
}
