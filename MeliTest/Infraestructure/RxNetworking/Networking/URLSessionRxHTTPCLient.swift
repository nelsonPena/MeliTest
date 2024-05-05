//
//  URLSessionHTTPCLient.swift
//  images
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation
import RxSwift

/// `URLSessionHTTPCLient` es una implementación de un cliente HTTP que utiliza la API URLSession de Foundation y Combine para realizar solicitudes HTTP.

class URLSessionRxHTTPCLient: HttpRxClient {
    
    /// Configura y devuelve una instancia de URLSession personalizada.
    ///
    /// Esta función crea una configuración de sesión con valores predeterminados, establece los intervalos de tiempo de espera para las solicitudes y los recursos,
    /// y devuelve una instancia de URLSession con la configuración proporcionada, delegado y cola de delegado.
    ///

    private let requestMaker: UrlSessionRxRequestMaker
    private let errorResolver: URLSessionErrorResolver
    
    /// Inicializa una nueva instancia de `URLSessionHTTPCLient` con las dependencias necesarias.
    ///
    /// - Parameters:
    ///   - session: Una instancia personalizable de URLSession. Por defecto, se utiliza URLSession.shared.
    ///   - requestMaker: Un creador de solicitudes personalizado.
    ///   - errorResolver: Un resolutor de errores personalizado.
    init(requestMaker: UrlSessionRxRequestMaker,
         errorResolver: URLSessionErrorResolver) {
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }
    
    /// Realiza una solicitud HTTP GET y devuelve una respuesta decodificada de tipo genérico utilizando Combine.
    ///
    /// - Parameters:
    ///   - endpoint: El punto final de la solicitud.
    ///   - baseUrl: La URL base para la solicitud.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una respuesta decodificada de tipo genérico o un error de `HttpClientError`.
    func makeRequest<T: Decodable>(requestModel: RequestEntity) -> Observable<T>  {
        
         guard let url = self.requestMaker.urlRequest(requestModel: requestModel) else {
               return Observable.error(HttpClientError.badURL)
           }

           let timeStart = DispatchTime.now()
           print("URL: \(url)")

           return Observable.create { observer in
               let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   let timeStop = DispatchTime.now()
                   let waitTime = timeStop.uptimeNanoseconds - timeStart.uptimeNanoseconds
                   let totalTime = Double(waitTime) / 1_000_000 // Convertir nanosegundos a milisegundos

                   if let error = error {
                       if let urLError = error as? URLError, urLError.code == .timedOut {
                           observer.onError(HttpClientError.timeOut)
                       } else {
                           observer.onError(error)
                       }
                       return
                   }

                   guard let httpResponse = response as? HTTPURLResponse else {
                       observer.onError(HttpClientError.badURL)
                       return
                   }

                   guard httpResponse.statusCode == 200 else {
                       observer.onError(self.errorResolver.resolve(statusCode: httpResponse.statusCode))
                       return
                   }

                   guard let data = data else {
                       observer.onError(HttpClientError.generic)
                       return
                   }

                   let responseString = String(data: data, encoding: .utf8) ?? "No read response JSON"

                  print( """
                       Response: \(responseString)
                   """)

                   let messageLogs = """
                           ******************** Response ********************
                           URL: \(url)
                           EndPoint \(requestModel.endPoint)
                           Headers \(requestModel.headers)
                           Body \(requestModel.body ?? ["": ""])
                           time Start \(timeStart)
                           time Start \(timeStop)
                           lat: \(totalTime)
                           response: \(responseString)
                           ******************** Response ********************
                           """
                   print( "\(messageLogs)")
                   
                   do {
                       let decodedObject = try JSONDecoder().decode(T.self, from: data)
                       observer.onNext(decodedObject)
                   } catch {
                       print("Decoding error: \(error)")
                       observer.onError(HttpClientError.parsingError)
                   }
                   observer.onCompleted()
               }

               task.resume()

               return Disposables.create {
                   task.cancel()
               }
           }
       }
}
