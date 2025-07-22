//
//  model.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import Foundation

class BaseModel: Codable {
    var verscancerern: String
    var microfic: String?
    var phrenlike: phrenlikeModel?
}

class phrenlikeModel: Codable {
    var filiatic: String?
    var plebofficeably: String?
    var polysure: polysureModel?
}

class polysureModel: Codable {
    var potamowise: String?
    var nema: [nemaModel]?
}

class nemaModel: Codable {
    var amongel: String?
    var goodfold: String?
    var theyine: String?
    var voluntacy: String?
    var raptorium: Int?//productid
}
