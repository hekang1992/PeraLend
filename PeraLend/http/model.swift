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
    var talkability: String?//schemurl
    var monitad: monitadModel?
    var formee: formeeModel?
    var soliden: [solidenModel]?
    var physalidpm: physalidpmModel?
    var gregcasey: Int?//face
    var lyst: [[String]]?
    var exactlyent: String?
    var crevitive: String?
    var applyess: String?
    var consumerfier: [consumerfierModel]?
    var rur: [rurModel]?
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

class monitadModel: Codable {
    var viscer: String?
    var road: String?
}

class formeeModel: Codable {
    var agcheoy: agcheoyModel?
    var ruptwise: String?
    var raptorium: String?
}

class agcheoyModel: Codable {
    var tinyaci: tinyaciModel?
}

class tinyaciModel: Codable {
    var officesion: String?
    var road: String?
}

class solidenModel: Codable {
    var road: String?
    var sufling: String?
    var salimiddleette: Int?//
    var outarian: String?//logo
    var viscer: String?
}

class physalidpmModel: Codable {
    var everybodyior: String?
    var salimiddleette: Int?//是否完整umid认证
}

class consumerfierModel: Codable {
    var cal: String?//cell类型
    var opinel: String?
    var readize: [readizeModel]?
    var road: String?
    var sufling: String?
    var verscancerern: String?
    var troubletion: Int?//键盘类型
    var chlor: String?
    var potamowise: String?
}

class readizeModel: Codable {
    var exactlyent: String?
    var potamowise: Int?
}

class rurModel: Codable {
    var exactlyent: String?
    var raptorium: Int?
    var rur: [rurModel]?
}
