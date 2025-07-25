//
//  fristLaunchNetwork.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//


import Alamofire
import AppTrackingTransparency
import FBSDKCoreKit
import SAMKeychain

class NetworkStatusManager {
    static let shared = NetworkStatusManager()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    func startListening() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                UserDefaults.standard.set("none", forKey: "network")
                UserDefaults.standard.synchronize()
            case .unknown:
                UserDefaults.standard.set("unknown", forKey: "network")
                UserDefaults.standard.synchronize()
            case .reachable(.ethernetOrWiFi):
                self.getAppTypeInit()
                UserDefaults.standard.set("WIFI", forKey: "network")
                UserDefaults.standard.synchronize()
            case .reachable(.cellular):
                self.getAppTypeInit()
                UserDefaults.standard.set("5G", forKey: "network")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func isReachable() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
}

extension NetworkStatusManager {
    
    private func getAppTypeInit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        self.getFcfda_idfa_od()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
        
    }
    
    private func getFcfda_idfa_od() {
        let dict = ["ennisuddenlytion": DeviceIdfvManager.shared.getDeviceID(),
                    "ornithsexia": DeviceIdfvManager.shared.getIDFA()]
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/voluntacy", parameters: dict) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        if let affectariumModel = success.phrenlike?.affectarium {
                            faceBookUpModel(from: affectariumModel)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                            }
                        }
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    private func faceBookUpModel(from model: affectariumModel) {
        Settings.shared.appID = model.buyen ?? ""
        Settings.shared.clientToken = model.clader ?? ""
        Settings.shared.displayName = model.playaneity ?? ""
        Settings.shared.appURLSchemeSuffix = model.hypnoence ?? ""
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
}

