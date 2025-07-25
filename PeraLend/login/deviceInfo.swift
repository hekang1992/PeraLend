//
//  deviceInfo.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/25.
//

import SystemServices
import DeviceKit
import UIKit

class SoftConfig {
    // 实例属性
    let prunel = "ios"
    let southain: String
    let othersment: String
    let tectfilmdom: String
    let mnestchildosity: Mnestchildosity
    let menstruee: Menstruee
    let leniture: Leniture
    let mot: Mot
    let dulcature: Dulcature
    
    // 初始化所有属性
    init() {
        self.southain = UIDevice.current.systemVersion
        self.othersment = SoftConfig.getLastTime()
        self.tectfilmdom = Bundle.main.bundleIdentifier ?? ""
        self.mnestchildosity = Mnestchildosity()
        self.menstruee = Menstruee()
        self.leniture = Leniture()
        self.mot = Mot()
        self.dulcature = Dulcature()
    }
    
    static func getLastTime() -> String {
        let uptime = ProcessInfo.processInfo.systemUptime
        let loginDate = Date(timeIntervalSinceNow: -uptime)
        return "\(Int(loginDate.timeIntervalSince1970 * 1000))"
    }
    
    func backAllDict() -> [String: Any] {
        return [
            "prunel": prunel,
            "southain": southain,
            "othersment": othersment,
            "tectfilmdom": tectfilmdom,
            "mnestchildosity": mnestchildosity.backAllDict(),
            "menstruee": menstruee.backAllDict(),
            "leniture": leniture.backAllDict(),
            "mot": mot.backAllDict(),
            "dulcature": dulcature.backAllDict()
        ]
    }
}

class Mnestchildosity {  // 类名改为大写
    let thermless: String
    let mouthess: String
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true  // 只启用一次
        self.thermless = String(Mnestchildosity.getBatteryLevel())
        self.mouthess = String(Mnestchildosity.isCharging())
    }
    
    static func getBatteryLevel() -> Int {
        let batteryLevel = Int(round(UIDevice.current.batteryLevel * 100))
        return max(0, min(batteryLevel, 100))
    }
    
    static func isCharging() -> Int {
        switch UIDevice.current.batteryState {
        case .charging, .full:
            return 1
        default:
            return 0
        }
    }
    
    func backAllDict() -> [String: Any] {
        return [
            "thermless": thermless,
            "mouthess": mouthess
        ]
    }
}

class Menstruee {
    let ennisuddenlytion: String
    let ornithsexia: String
    let mediafold: String
    
    let amphiacious: String
    let developness: String
    let hyoad: String
    let septen: String
    let dermile: String
    
    let officialward: String
    let nonacious: String
    let acetsendence: String
    let hibitious: String
    let authorityain: String
    
    init() {
        self.ennisuddenlytion = DeviceIdfvManager.shared.getDeviceID()
        self.ornithsexia = DeviceIdfvManager.shared.getIDFA()
        self.mediafold = NetworkInfo.getBSSID() ?? ""
        self.amphiacious = String(Int(Date().timeIntervalSince1970 * 1000))
        self.developness = String(NetworkInfo.isUsingProxy())
        self.hyoad = String(NetworkInfo.isUsingVPN())
        self.septen = String(DeviceBigModelConfig.isJailbroken())
        self.dermile = String(DeviceBigModelConfig.isSimulator())
        self.officialward = Locale.preferredLanguages.first ?? "en"
        self.nonacious = ""
        self.acetsendence = UserDefaults.standard.object(forKey: "network") as? String ?? ""
        self.hibitious = NSTimeZone.system.abbreviation() ?? ""
        self.authorityain = DeviceBigModelConfig.systemUptime()
    }
    
    func backAllDict() -> [String: Any] {
        return [
            "ennisuddenlytion": ennisuddenlytion,
            "ornithsexia": ornithsexia,
            "mediafold": mediafold,
            "amphiacious": amphiacious,
            "developness": developness,
            "hyoad": hyoad,
            "septen": septen,
            "dermile": dermile,
            "officialward": officialward,
            "nonacious": nonacious,
            "acetsendence": acetsendence,
            "hibitious": hibitious,
            "authorityain": authorityain
        ]
    }
}

class Leniture {
    
    let capr: String
    let growain: String
    let typeoon: String
    let oreximiddleacity: String
    let expert: String
    let felinoward: String
    let taxast: String
    let allelassumeior: String
    let vicesimtooacle: String
    let ownerety: String
    init() {
        self.capr = ""
        self.growain = "iPhone"
        self.typeoon = ""
        self.oreximiddleacity = String(Int(screenheight))
        self.expert = String(Int(screenwidth))
        self.felinoward = "iPhone"
        self.taxast = Device.current.description
        self.allelassumeior = Device.identifier
        self.vicesimtooacle = String(Device.current.diagonal)
        self.ownerety = Device.current.systemVersion ?? ""
    }
    
    func backAllDict() -> [String: Any] {
        return [
            "capr": capr,
            "growain": growain,
            "typeoon": typeoon,
            "oreximiddleacity": oreximiddleacity,
            "expert": expert,
            "felinoward": felinoward,
            "taxast": taxast,
            "allelassumeior": allelassumeior,
            "vicesimtooacle": vicesimtooacle,
            "ownerety": ownerety
        ]
    }
    
}

class Mot {
    let hospitalally: String
    let tauruse: [[String: String]]
    let ont: [String: String]
    let myridom: Int
    
    init() {
        self.hospitalally = NetworkInfo.getIPAddress() ?? ""
        self.ont = ["exactlyent": NetworkInfo.getSSID() ?? "",
                    "ordereur": NetworkInfo.getBSSID() ?? "",
                    "mediafold": NetworkInfo.getBSSID() ?? "",
                    "ownerarian": NetworkInfo.getSSID() ?? ""]
        self.tauruse = [ont]
        self.myridom = tauruse.count
    }
    
    func backAllDict() -> [String: Any] {
        return [
            "hospitalally": hospitalally,
            "tauruse": tauruse,
            "ont": ont,
            "myridom": myridom
        ]
    }
    
    
}

class ont {
    let exactlyent: String
    let ordereur: String
    let mediafold: String
    let ownerarian: String
    init() {
        self.exactlyent = NetworkInfo.getSSID() ?? ""
        self.ordereur = NetworkInfo.getBSSID() ?? ""
        self.mediafold = NetworkInfo.getBSSID() ?? ""
        self.ownerarian = NetworkInfo.getSSID() ?? ""
    }
    func backAllDict() -> [String: Any] {
        return [
            "exactlyent": exactlyent,
            "ordereur": ordereur,
            "mediafold": mediafold,
            "ownerarian": ownerarian
        ]
    }
}

class Dulcature {
    let soundier: Int
    let plorior: Int
    let trit: Int
    let methodise: Int
    
    init() {
        self.soundier = Dulcature.freeDisk() ?? 0
        self.plorior = Dulcature.allDisk() ?? 0
        self.trit = Dulcature.totalMemory() ?? 0
        self.methodise = Dulcature.activeMemoryinRaw() ?? 0
    }

    static func totalMemory() -> Int? {
        let total = SystemServices.shared().totalMemory * 1000 * 1000
        return Int(exactly: NSNumber(value: total).intValue)
    }

    static func activeMemoryinRaw() -> Int? {
        let active = SystemServices.shared().activeMemoryinRaw * 1000 * 1000
        return Int(exactly: NSNumber(value: active).intValue)
    }
    
    static func freeDisk() -> Int? {
        return Int(exactly: SystemServices.shared().longFreeDiskSpace)
    }

    static func allDisk() -> Int? {
        return Int(exactly: SystemServices.shared().longDiskSpace)
    }

    func backAllDict() -> [String: Any] {
        return [
            "soundier": soundier,
            "plorior": plorior,
            "trit": trit,
            "methodise": methodise
        ]
    }
    
}

