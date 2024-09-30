//
//  MemModel.swift
//  Fortuna telling and memes
//
//  Created by Катя on 27.09.2024.
//

import UIKit

struct MemModel: Decodable {
    var data: DataModel
}

struct DataModel: Decodable {
    var memes: [InfoDataModel]
}

struct InfoDataModel: Decodable {
    var id: String
    var name: String
    var url: String
    var width: Int
    var height: Int
    var box_count: Int
    var captions: Int
}
