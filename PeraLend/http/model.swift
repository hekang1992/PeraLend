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
    var torpefold: torpefoldModel?
    var affectarium: affectariumModel?
    var discussaire: discussaireModel?
    var cantesque: cantesqueModel?
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
    var apertaster: String?
    var ruptwise: String?
}

class monitadModel: Codable {
    var viscer: String?
    var road: String?
}

class formeeModel: Codable {
    var agcheoy: agcheoyModel?
    var ruptwise: String?
    var raptorium: String?
    var songfic: String?
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
    var cal: String?
    var opinel: String?
    var readize: [readizeModel]?
    var road: String?
    var sufling: String?
    var verscancerern: String?
    var troubletion: Int?
    var chlor: String?
    var potamowise: String?
    var consumerfier: [consumerfierModel]?

    enum CodingKeys: String, CodingKey {
        case cal, opinel, readize, road, sufling, verscancerern, troubletion, chlor, potamowise, consumerfier
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        cal = try? container.decode(String.self, forKey: .cal)
        opinel = try? container.decode(String.self, forKey: .opinel)
        readize = try? container.decode([readizeModel].self, forKey: .readize)
        road = try? container.decode(String.self, forKey: .road)
        sufling = try? container.decode(String.self, forKey: .sufling)
        verscancerern = try? container.decode(String.self, forKey: .verscancerern)
        troubletion = try? container.decode(Int.self, forKey: .troubletion)
        chlor = try? container.decode(String.self, forKey: .chlor)

        if let str = try? container.decode(String.self, forKey: .potamowise) {
            potamowise = str
        } else if let intVal = try? container.decode(Int.self, forKey: .potamowise) {
            potamowise = String(intVal)
        }

        consumerfier = try? container.decode([consumerfierModel].self, forKey: .consumerfier)
    }
}

class readizeModel: Codable {
    var exactlyent: String?
    var potamowise: String?

    enum CodingKeys: String, CodingKey {
        case exactlyent, potamowise
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        exactlyent = try? container.decode(String.self, forKey: .exactlyent)

        if let str = try? container.decode(String.self, forKey: .potamowise) {
            potamowise = str
        } else if let intVal = try? container.decode(Int.self, forKey: .potamowise) {
            potamowise = String(intVal)
        }
    }
}


class rurModel: Codable {
    var exactlyent: String?
    var raptorium: Int?
    var officesion: String?
    var tendorium: String?
    var sarcolanditious: String?
    var mollfier: String?
    var relationText: String?
    var rur: [rurModel]?
    var fodlike: [fodlikeModel]?
    var sesquireallyment: sesquireallymentModel?
}

class torpefoldModel: Codable {
    var rur: [rurModel]?
}

class fodlikeModel: Codable {
    var exactlyent: String?
    var potamowise: String?
}

class affectariumModel: Codable {
    var buyen: String?
    var clader: String?
    var hypnoence: String?
    var playaneity: String?
}

class sesquireallymentModel: Codable {
    var apertaster: String?
    var beforeress: String?//button text
    var introism: String?
    var odorship: String?
    var photitor: String?
    var ruptwise: String?
    var subteraceous: String?
    var jointure: String?
    var therier: Int?//产品ID
    var diaconditionry: Int?//订单状态ID
}

class discussaireModel: Codable {
    var nema: [nemaModel]?
}

class cantesqueModel: Codable {
    var nema: [nemaModel]?
}
