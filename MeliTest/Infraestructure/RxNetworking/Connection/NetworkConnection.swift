//
//  NetworkConnection.swift
//  Sodexo
//
//  Created by Reinner Steven Daza Leiva on 24/09/21.
//

import Foundation
import Network
import UIKit

/// Enumeración que representa los tipos de conexión de red posibles
enum NetworkConectionType {
    case WIFI
    case CELL
    case WIREDETHERNET
    case UNKNOWN
}

/// Clase que gestiona la conexión de red
final class NetworkConnection: NetworkConnectionProtocol {
    public static let shared = NetworkConnection()

    private let monitor = NWPathMonitor()

    private var statusNetwork = false
    private var networkConnectionType: NetworkConectionType = .UNKNOWN

    private let queue = DispatchQueue(label: "internetConnectionMonitor")

    init() {
        configNetworkPathMonitor()
    }

    /// Configura el monitor de ruta de red
    public func configNetworkPathMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.statusNetwork = path.status == .satisfied
            self?.updateNetworkConnectionType(path)
        }
    }

    /// Actualiza el tipo de conexión de red según la ruta proporcionada
    /// - Parameter path: Ruta de red que contiene información sobre la conexión
    public func updateNetworkConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            networkConnectionType = .WIFI
        } else if path.usesInterfaceType(.cellular) {
            networkConnectionType = .CELL
        } else if path.usesInterfaceType(.wiredEthernet) {
            networkConnectionType = .WIFI
        } else {
            networkConnectionType = .UNKNOWN
        }
    }

    /// Obtiene el estado de la conexión de red
    /// - Returns: `true` si la conexión de red está disponible, `false` en caso contrario.
    public func getStatusNetwork() -> Bool {
        return statusNetwork
    }

    /// Inicia el escaneo de red
    public func networkScanStart() {
        monitor.start(queue: queue)
    }

    /// Detiene el escaneo de red
    public func networkScanStop() {
        monitor.cancel()
    }

    /// Verifica si la URL proporcionada es válida y puede abrirse
    /// - Parameter urlString: URL a verificar
    /// - Returns: `true` si la URL es válida y puede abrirse, `false` en caso contrario.
    public func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
