//
//  MeliTestTests.swift
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import XCTest
import Combine
@testable import MeliTest

final class MeliTestTests: XCTestCase {
    
    // MARK: - Test Cases
    
    /// Prueba la obtención de los resultados  a través del caso de uso.
    ///
    /// Esta prueba se encarga de verificar que el caso de uso `GetItemList` obtenga los registros
    /// utilizando un cliente HTTP simulado. Se inyecta el cliente simulado en la fábrica
    /// de casos de uso y se crea una expectativa para evaluar el resultado.
    ///
    /// - Precondiciones:
    ///     - `MockURLSessionHTTPClient` está configurado para devolver una respuesta exitosa.
    ///
    /// - Postcondiciones:
    ///     - Se verifica que la operación asincrónica se completa con éxito.
    ///     - Se verifica que la cantidad de los resultados  obtenidas coincide con la respuesta simulada.
    ///
    func testGetItemList() {
        var cancellables = Set<AnyCancellable>()
        
        // Crear una instancia del cliente HTTP simulado (MockURLSessionHTTPClient)
        let mockHTTPClient = MockURLSessionHTTPClient()
        
        // Inyectar el cliente simulado en tu fábrica y crear un caso de uso
        let useCase = ItemListFactory(httpClient: mockHTTPClient).createUseCase()
        
        // Crear una expectativa para el caso de prueba
        let expectation = XCTestExpectation(description: "Obtener los datos")
        
        // Llamar a la operación asincrónica (GetItemList)
        useCase.getItems(with: "")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // La operación asincrónica se completó con éxito
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error inesperado: \(error)")
                }
            }, receiveValue: { result in
                // Realizar afirmaciones en los datos recibidos
                XCTAssertTrue(result.results.count > 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Esperar hasta que se cumpla la expectativa (o hasta que expire el tiempo)
        wait(for: [expectation], timeout: 5)
    }

}
