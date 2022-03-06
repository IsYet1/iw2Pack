//
//  Item.swift
//  iw2Pack
//
//  Created by Don McKenzie on 18-Jan-22.
//

import Foundation

struct ItemMetadata: Codable {
    var category: String?
    var location: String?
}

struct Item: Codable {
    var id: String?
    var name: String?
    var category: String?
    var itemId: String?
    var location: String?
    var packed: Bool?
    var staged: Bool?
    var selected: Bool?
//    var metadata: ItemMetadata?
}

struct ItemToAddToEventList: Codable {
    var id: String?
    var itemId: String
    var packed: Bool
    var staged: Bool
}

struct ItemUpdate: Codable {
    var id: String
    var name: String
    var category: String
    var location: String
}

struct ItemToAdd: Codable {
    var id: String?
    var name: String
    var category: String
    var location: String
}

func toItem(itemIn: ItemToAdd) -> Item {
    return Item(id: itemIn.id, name: itemIn.name, category: itemIn.category, location: itemIn.location)
}
