//
//  Untitled.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/25.
//

import SystemConfiguration.CaptiveNetwork
import UIKit
import Foundation

class NetworkInfo {
    
    class func getBSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        
        for interface in interfaces {
            guard let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else {
                continue
            }
            
            if let bssid = interfaceInfo["BSSID"] as? String {
                return bssid
            }
        }
        
        return nil
    }
    
    class func getSSID() -> String? {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            currentSSID = myDict["SSID"] as? String ?? ""
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
    class func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                // Check for IPv4 or IPv6
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name = String(cString: (interface?.ifa_name)!)
                    if name == "en0" || name == "en2" || name == "en3" || name == "en4" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr,
                                   socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                   &hostname,
                                   socklen_t(hostname.count),
                                   nil,
                                   socklen_t(0),
                                   NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
    class func getMACAddress() -> String? {
        
        return "02:00:00:00:00:00"
    }
    
    
    static func isUsingProxy() -> Int {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any] else {
            return 0
        }
        
        if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
            return 1
        }
        
        if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
            return 1
        }
        
        return 0
    }
    
    static func isUsingVPN() -> Int {
        let cfDict = CFNetworkCopySystemProxySettings()
        guard let settings = cfDict?.takeRetainedValue() as? [String: Any] else {
            return 0
        }
        
        if let scopes = settings["__SCOPED__"] as? [String: Any] {
            for (key, _) in scopes {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") || key.contains("utun") {
                    return 1
                }
            }
        }
        return 0
    }
    
}


class DeviceBigModelConfig {
    
    static func isJailbroken() -> Int {
#if targetEnvironment(simulator)
        return 0
#else
        // 检查常见越狱文件路径
        let jailbreakFilePaths = [
            "/Applications/Cydia.app",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
        ]
        
        for path in jailbreakFilePaths {
            if FileManager.default.fileExists(atPath: path) {
                return 1
            }
        }
        
        let testPath = "/private/jb_test.txt"
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testPath)
            return 1
        } catch {
            
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
            return 1
        }
        
        return 0
#endif
    }
    
    
    static func isSimulator() -> Int {
#if targetEnvironment(simulator)
        return 1
#else
        return 0
#endif
    }
    
    static func systemUptime() -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
}
