//
//  ItemListPresentableItem.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

struct ItemListPresentableItem {
    
    let title: String
    let condition: String
    let thumbnail: String
    let attributes: [AttributePresentableItem]
    
    internal init(domainModel: ItemResult) {
        self.title = domainModel.title.capitalized(with: .current)
        self.thumbnail = domainModel.thumbnail
        self.condition = domainModel.condition.getValue()
        self.attributes =  domainModel.attributes.map{ .init(name: $0.name ?? "",
                                                             valueName: $0.valueName ?? "") }
    }
}

struct AttributePresentableItem {
    let name, valueName: String
}
    
