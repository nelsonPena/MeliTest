//
//  ItemListErrorMapper.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

class ItemPresentableErrorMapper {
    func map(error: DomainError?) -> String {
        guard error == .generic else {
            return "generic_text_error".localized
        }
        return "try_later_text_error".localized
    }
}
