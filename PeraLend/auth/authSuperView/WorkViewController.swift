//
//  WorkViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/22.
//

import UIKit
import BRPickerView

class WorkViewController: BaseViewController {
    
    var productID: String = ""
    
    var consumerfierArray: [consumerfierModel] = []
    
    var time: String = ""
    let locationService = LocationService()  // 保留引用
    
    lazy var personView: PersonalView = {
        let personView = PersonalView()
        personView.plendImageView.image = UIImage(named: "p_two_image")
        return personView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        time = String(Int(Date().timeIntervalSince1970 * 1000))
        locationService.startLocation { locationInfo in
            LocationModelSingle.shared.locationInfo = locationInfo
        }
        view.addSubview(personView)
        personView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        personView.headView.backBlock = { [weak self] in
            self?.popToSelectController()
        }
        
        getWorkInfo()
        
        
        personView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            var endDict: [String: String] = ["pinguly": productID]
            for model in consumerfierArray {
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
            NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/graphoite", parameters: endDict) { [weak self] result in
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
                            PongCombineManager.goYourPoint(with: self.productID, type: "6", publicfic: self.time, probar: probar, cyston: cyston)
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

extension WorkViewController {
    
    private func getWorkInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/fetose", parameters: ["pinguly": productID]) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    self.consumerfierArray = success.phrenlike?.consumerfier ?? []
                    self.personView.consumerfierArray = success.phrenlike?.consumerfier ?? []
                    self.personView.tableView.reloadData()
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

extension WorkViewController {
    
    
    
    
}
