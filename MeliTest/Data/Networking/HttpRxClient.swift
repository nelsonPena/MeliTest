//
//  HttpRxClient.swift
//  MeliTest
//
//  Created by Nelson Peña Agudelo on 16/04/24.
//

import RxSwift

protocol HttpRxClient {
    func makeRequest<T: Decodable>(requestModel: RequestEntity) -> Observable<T>
}
