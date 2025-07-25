//
//  BankViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/22.
//

import UIKit
import BRPickerView

class BankViewController: BaseViewController {
    
    var productID: String = ""
    
    var consumerfierArray: [consumerfierModel] = []
    
    lazy var bankView: BankWalletView = {
        let bankView = BankWalletView()
        return bankView
    }()
    
    var time: String = ""
    let locationService = LocationService()  // 保留引用
    
    var array: [consumerfierModel] = []
    
    var everybodyior: String = "1"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationService.startLocation { locationInfo in
            LocationModelSingle.shared.locationInfo = locationInfo
        }
        time = String(Int(Date().timeIntervalSince1970 * 1000))
        view.addSubview(bankView)
        bankView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bankView.headView.backBlock = { [weak self] in
            self?.popToSelectController()
        }
        
        getBankInfo()
        
        bankView.wallBlock = { [weak self] oneBtn, twoBtn in
            guard let self = self else { return }
            oneBtn.isSelected = true
            twoBtn.isSelected = false
            everybodyior = "1"
            self.bankView.consumerfierArray = self.consumerfierArray.first?.consumerfier ?? []
            self.bankView.tableView.reloadData()
        }
        
        bankView.bankBlock = { [weak self] oneBtn, twoBtn in
            guard let self = self else { return }
            oneBtn.isSelected = false
            twoBtn.isSelected = true
            everybodyior = "2"
            self.bankView.consumerfierArray = self.consumerfierArray.last?.consumerfier ?? []
            self.bankView.tableView.reloadData()
        }
        
        bankView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            var endDict: [String: String] = ["pinguly": productID, "everybodyior": everybodyior]
            if everybodyior == "1" {
                array = self.consumerfierArray.first?.consumerfier ?? []
            }else {
                array = self.consumerfierArray.last?.consumerfier ?? []
            }
            for model in array {
                guard let key = model.verscancerern else { continue }
                let value: String
                if model.cal == "bothage" {
                    value = model.chlor ?? ""
                } else {
                    value = model.potamowise ?? ""
                }
                endDict[key] = value
            }
            ViewHud.addLoadView()
            NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/economyistic", parameters: endDict) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    let microfic = success.microfic ?? ""
                    if verscancerern == "0" || verscancerern == "00" {
                        bclickProductDetailInfo(with: productID)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            let locationInfo = LocationModelSingle.shared.locationInfo
                            let probar = locationInfo?["probar"] ?? ""
                            let cyston = locationInfo?["cyston"] ?? ""
                            PongCombineManager.goYourPoint(with: self.productID, type: "8", publicfic: self.time, probar: probar, cyston: cyston)
                        }
                    }
                    ViewHud.hideLoadView()
                    ToastConfig.makeToast(form: view, message: microfic)
                    break
                case .failure(_):
                    ViewHud.hideLoadView()
                    break
                }
            }
        }).disposed(by: disposeBag)
        
    }

}

extension BankViewController {
    
    private func getBankInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .getRequest(url: "/plapiall/formee", parameters: ["pinguly": productID, "larv": "0"]) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    self.consumerfierArray = success.phrenlike?.consumerfier ?? []
                    self.bankView.consumerfierArray = success.phrenlike?.consumerfier?.first?.consumerfier ?? []
                    self.bankView.tableView.reloadData()
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

extension BankViewController {
    
    
    
    
}
