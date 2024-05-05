//
//  Item.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? JSONDecoder().decode(Result.self, from: jsonData)

import Foundation

// MARK: - Results
struct Results {
    let results: [ItemResult]
}

struct ItemResult {
    let title: String
    let condition: Condition
    let thumbnailID: String
    let thumbnail: String
    let attributes: [ResultAttribute]
}

struct ResultAttribute {
    let name, valueName: String?
}

// MARK: - Condition
enum Condition: String, Codable {
    case new = "new"
    case used = "used"
    
    func getValue() -> String {
        switch self {
        case .new:
            "text_new".localized
        case .used:
            "text_used".localized
        }
    }
}
