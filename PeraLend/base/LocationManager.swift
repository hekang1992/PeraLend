//
//  lo.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/25.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var onLocationResult: (([String: String]) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocation(completion: @escaping ([String: String]) -> Void) {
        self.onLocationResult = completion
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("反向地理编码失败: \(error?.localizedDescription ?? "")")
                return
            }
            
            let result: [String: String] = [
                "satious": placemark.administrativeArea ?? "",
                "arborfine": placemark.isoCountryCode ?? "",
                "coracdom": placemark.country ?? "",
                "biblatory": placemark.name ?? "",
                "cyston": "\(latitude)",
                "probar": "\(longitude)",
                "millwise": placemark.locality ?? "",
                "lepro": placemark.subLocality ?? "",
                "himselfling": placemark.subLocality ?? ""
            ]
            
            self.onLocationResult?(result)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}


class PongCombineManager {
    
    static func goYourPoint(with productID: String,
                            type: String,
                            publicfic: String,
                            probar: String,
                            cyston: String) {
        let your = DeviceIdfvManager.shared.getDeviceID()
        let summerency = DeviceIdfvManager.shared.getIDFA()
        let probar = probar
        let cyston = cyston
        let endTime = String(Int(Date().timeIntervalSince1970 * 1000))
        let dict = ["therier": productID,
                    "ofless": type,
                    "your": your,
                    "summerency": summerency,
                    "publicfic": publicfic,
                    "ethn": endTime,
                    "probar": probar,
                    "cyston": cyston]
        NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/ultimid", parameters: dict) { resulut in
            switch resulut {
            case .success(_):
                 break
            case .failure(_):
                break
            }
        }
    }
    
}
