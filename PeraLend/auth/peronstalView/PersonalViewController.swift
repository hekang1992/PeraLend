//
//  PersonalViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import BRPickerView

class PersonalViewController: BaseViewController {
    
    var productID: String = ""
    
    var consumerfierArray: [consumerfierModel] = []
    
    lazy var personView: PersonalView = {
        let personView = PersonalView()
        return personView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(personView)
        personView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        personView.headView.backBlock = { [weak self] in
            self?.popToSelectController()
        }
        
        getPersonalInfo()
        
        
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
            print("endDict=====\(endDict)")
        }).disposed(by: disposeBag)
        
    }


}

extension PersonalViewController {
    
    private func getPersonalInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/messageible", parameters: ["pinguly": productID]) { [weak self] result in
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

extension PersonalViewController {
    
    
    
    
}
