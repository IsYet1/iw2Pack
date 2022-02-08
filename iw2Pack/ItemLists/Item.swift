//
//  Item.swift
//  iw2Pack
//
//  Created by Don McKenzie on 18-Jan-22.
//

import Foundation

struct Metadata: Codable {
    var category: String?
    var location: String?
}

struct Item: Codable {
    var id: String?
    var name: String?
    var itemId: String?
    var packed: Bool?
    var staged: Bool?
    var category: String?
    var metadata: String?
}
