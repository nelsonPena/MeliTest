//
//  ResultsDTO.swift
//  MeliTest
//
//  Created by Nelson Peña on 1/02/24.
//

import Foundation

// MARK: - Results
struct ResultsDTO: Codable {
    let results: [ResultDTO]
    
    func mapper() -> Results {
        .init(results: self.results.map{
            .init(
                title: $0.title,
                condition: Condition(rawValue: $0.condition.rawValue) ?? .new,
                thumbnailID: $0.thumbnailID,
                thumbnail: $0.thumbnail,
                attributes: $0.attributes.map{ $0.mapper() }
            )
        })
    }
}


// MARK: - Result
struct ResultDTO: Codable {
    let id, title: String
    let condition: ConditionDTO
    let thumbnailID: String
    let thumbnail: String
    let attributes: [ResultAttributeDTO]
  
    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case thumbnail
        case attributes
    }
}

// MARK: - ResultAttribute
struct ResultAttributeDTO: Codable {
    let name, valueName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case valueName = "value_name"
    }
    
    func mapper() -> ResultAttribute {
        .init(
            name: self.name,
            valueName: self.valueName
        )
    }
}

// MARK: - Condition
enum ConditionDTO: String, Codable {
    case new = "new"
    case used = "used"
}


