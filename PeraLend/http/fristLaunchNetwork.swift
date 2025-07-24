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
                print("❌ 网络不可用")
            case .unknown:
                print("❓ 网络状态未知")
            case .reachable(.ethernetOrWiFi):
                self.getAppTypeInit()
            case .reachable(.cellular):
                self.getAppTypeInit()
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
                        Task {
                            await self.getFceBookInfo()
                        }
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
        
    }
    
    private func getFceBookInfo() async {
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

