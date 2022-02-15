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
    var packed: Bool?
    var staged: Bool?
//    var metadata: ItemMetadata?
}
