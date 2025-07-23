//
//  config.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/23.
//

import BRPickerView

class FirstModel {
    static func getFirstModelArray(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? readizeModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = String(proviceDic.potamowise ?? 0)
            proviceModel.name = proviceDic.exactlyent
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            result.append(proviceModel)
        }
        return result
    }
}

class AddressModel {
    static func getAddressModelArray(dataSourceArr: [Any]) -> [BRProvinceModel] {
        return dataSourceArr.compactMap { item in
            guard let provinceDic = item as? rurModel else { return nil }
            
            let provinceModel = BRProvinceModel()
            provinceModel.code = String(provinceDic.raptorium ?? 0)
            provinceModel.name = provinceDic.exactlyent
            provinceModel.index = dataSourceArr.firstIndex { $0 as AnyObject === provinceDic as AnyObject } ?? 0
            
            let cityList = provinceDic.rur ?? []
            provinceModel.citylist = cityList.enumerated().map { index, cityDic in
                let cityModel = BRCityModel()
                cityModel.code = String(cityDic.raptorium ?? 0)
                cityModel.name = cityDic.exactlyent
                cityModel.index = index
                
                let areaList = cityDic.rur ?? []
                cityModel.arealist = areaList.enumerated().map { areaIndex, areaDic in
                    let areaModel = BRAreaModel()
                    areaModel.code = String(areaDic.raptorium ?? 0)
                    areaModel.name = areaDic.exactlyent
                    areaModel.index = areaIndex
                    return areaModel
                }
                
                return cityModel
            }
            
            return provinceModel
        }
    }
}

class AdressModelSingle {
    static let shared = AdressModelSingle()
    private init() {}
    var modelArray: [BRProvinceModel]?
}
