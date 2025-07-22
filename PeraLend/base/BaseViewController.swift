//
//  BaseViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
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
        if let navigationController = self.navigationController {
            for viewController in navigationController.viewControllers {
                if let targetVC = viewController as? AVMuidViewController {
                    navigationController.popToViewController(targetVC, animated: true)
                    break
                }
            }
        }
    }
    
    //点击获取产品详情
    func bclickProductDetailInfo(with productID: String) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/saxaneous", parameters: ["pinguly": productID]) { result in
                switch result {
                case .success(let success):
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
    
}
