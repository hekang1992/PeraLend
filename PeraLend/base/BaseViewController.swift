//
//  BaseViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()
    
    lazy var listView: BaseView = {
        let listView = BaseView()
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension BaseViewController {
    
    func popToSelectController() {
        guard let navigationController = self.navigationController else { return }
        
        var foundTarget = false
        for viewController in navigationController.viewControllers {
            if let targetVC = viewController as? AVMuidViewController {
                navigationController.popToViewController(targetVC, animated: true)
                foundTarget = true
                break
            }
        }
        
        // If target view controller wasn't found, pop to root
        if !foundTarget {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    //根据订单号获取跳转地址
    func orderNoInfo(with orderNo: String, complete: @escaping ((String) -> Void)) {
        ViewHud.addLoadView()
        let dict = ["mit": orderNo]
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/polysure", parameters: dict) { result in
            switch result {
            case .success(let success):
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    complete(success.phrenlike?.talkability ?? "")
                }
                ViewHud.hideLoadView()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
    //点击获取产品详情
    func bclickProductDetailInfo(with productID: String) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/saxaneous", parameters: ["pinguly": productID]) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        let monitad = success.phrenlike?.monitad
                        let viscer = monitad?.viscer ?? ""
                        if !viscer.isEmpty {
                            if viscer == "brachiality" {
                                
                            }else if viscer == "germinate" {
                                let personalVc = PersonalViewController()
                                personalVc.productID = productID
                                self.navigationController?.pushViewController(personalVc, animated: true)
                            }else if viscer == "lunfoodad" {
                                let workVc = WorkViewController()
                                workVc.productID = productID
                                self.navigationController?.pushViewController(workVc, animated: true)
                            }else if viscer == "laughwise" {
                                let phoneVc = PhoneViewController()
                                phoneVc.productID = productID
                                self.navigationController?.pushViewController(phoneVc, animated: true)
                            }else if viscer == "clinoid" {
                                let bankVc = BankViewController()
                                bankVc.productID = productID
                                self.navigationController?.pushViewController(bankVc, animated: true)
                            }
                        }else {
                            let songfic = success.phrenlike?.formee?.songfic ?? ""
                            orderNoInfo(with: songfic) { pageUrl in
                                let webVc = WebViewController()
                                webVc.pageUrl = pageUrl
                                self.navigationController?.pushViewController(webVc, animated: true)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                let locationInfo = LocationModelSingle.shared.locationInfo
                                let probar = locationInfo?["probar"] ?? ""
                                let cyston = locationInfo?["cyston"] ?? ""
                                PongCombineManager.goYourPoint(with: productID, type: "9", publicfic: String(Int(Date().timeIntervalSince1970 * 1000)), probar: probar, cyston: cyston)
                            }
                            
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
    
    func showPermissionDeniedAlert(for permission: String, customMessage: String? = "0") {
        let alert = UIAlertController(
            title: "Permission required",
            message: "To use this feature, please grant \(permission) access in Settings.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Setting", style: .default) { _ in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        present(alert, animated: true, completion: nil)
    }
    
}
