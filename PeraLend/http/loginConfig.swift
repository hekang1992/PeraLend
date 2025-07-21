//
//  loginConfig.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import DeviceKit
import SAMKeychain
import AppTrackingTransparency
import AdSupport

final class LoginConfig {
    
    // MARK: - Constants
    private enum Constants {
        static let platform = "ios"
        static let appVersion = "1.0.0"
        static let apiIdentifier = "peralendapi"
        static let loginPageKey = "LOGINPAGE"
    }
    
    // MARK: - Properties
    let platform: String
    let appVersion: String
    let deviceName: String
    let deviceId: String
    let osVersion: String
    let apiIdentifier: String
    let loginPage: String
    let deviceIdDuplicate: String  // Note: This appears to duplicate deviceId
    
    // MARK: - Initialization
    init() {
        self.platform = Constants.platform
        self.appVersion = Constants.appVersion
        self.deviceName = UIDevice.current.name
        self.deviceId = DeviceIdfvManager.shared.getDeviceID()
        self.osVersion = UIDevice.current.systemVersion
        self.apiIdentifier = Constants.apiIdentifier
        self.loginPage = UserDefaults.standard.string(forKey: Constants.loginPageKey) ?? ""
        self.deviceIdDuplicate = DeviceIdfvManager.shared.getDeviceID()  // Consider removing if not needed
    }
    
    // MARK: - Public Methods
    
    var dictionaryRepresentation: [String: String] {
        return [
            "baloast": platform,
            "interviewsome": appVersion,
            "jac": deviceName,
            "manuate": deviceId,
            "villor": osVersion,
            "fanweaponaneous": apiIdentifier,
            "plebofficeably": loginPage,
            "quadrth": deviceIdDuplicate
        ]
    }
}


final class DeviceIdfvManager {
    
    // MARK: - Shared Instance
    static let shared = DeviceIdfvManager()
    
    // MARK: - Private Properties
    private let serviceName = "cpo.pera.lend"
    private let accountName = "idfv"
    
    // MARK: - Public Methods
    
    /// Retrieves the IDFA (Identifier for Advertisers)
    /// - Returns: String representation of the advertising identifier
    func getIDFA() -> String {
        // Check advertising tracking status
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    /// Retrieves or generates a persistent device identifier
    /// - Returns: String representation of the device identifier
    func getDeviceID() -> String {
        // Try to retrieve existing ID from keychain
        if let existingID = try? retrieveDeviceIDFromKeychain() {
            return existingID
        }
        
        // Generate new ID
        let newID = generateNewDeviceID()
        
        // Store in keychain
        storeDeviceIDInKeychain(newID)
        
        return newID
    }
    
    // MARK: - Private Methods
    
    private func retrieveDeviceIDFromKeychain() throws -> String {
        if let deviceID = SAMKeychain.password(forService: serviceName, account: accountName) {
            return deviceID
        }
        throw KeychainError.deviceIDNotFound
    }
    
    private func generateNewDeviceID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    private func storeDeviceIDInKeychain(_ id: String) {
        let success = SAMKeychain.setPassword(id, forService: serviceName, account: accountName)
        if !success {
            print("Failed to store device ID in keychain")
            // Consider additional error handling here
        }
    }
    
    // MARK: - Error Handling
    
    private enum KeychainError: Error {
        case deviceIDNotFound
        case keychainAccessFailed
    }
}
