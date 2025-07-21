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
}
