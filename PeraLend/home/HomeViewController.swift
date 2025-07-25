//
//  HomeViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import UIKit
import RxRelay
import MJRefresh
import CoreLocation

class HomeViewController: BaseViewController {
    
    lazy var playView: HomeView = {
        let playView = HomeView()
        playView.isHidden = true
        return playView
    }()
    
    lazy var anotherView: OtherView = {
        let anotherView = OtherView()
        anotherView.isHidden = true
        return anotherView
    }()
    
    let locationService = LocationService()  // 保留引用
    
    var homeModel = BehaviorRelay<phrenlikeModel?>(value: nil)
    
    var time: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        time = String(Int(Date().timeIntervalSince1970 * 1000))
        locationService.startLocation { locationInfo in
            LocationModelSingle.shared.locationInfo = locationInfo
            let locationInfo = LocationModelSingle.shared.locationInfo
            
            let satious = locationInfo?["satious"] ?? ""
            let arborfine = locationInfo?["arborfine"] ?? ""
            let coracdom = locationInfo?["coracdom"] ?? ""
            let biblatory = locationInfo?["biblatory"] ?? ""
            let cyston = locationInfo?["cyston"] ?? ""
            let probar = locationInfo?["probar"] ?? ""
            let millwise = locationInfo?["millwise"] ?? ""
            
            let dict = [
                "satious": satious,
                "arborfine": arborfine,
                "coracdom": coracdom,
                "biblatory": biblatory,
                "cyston": cyston,
                "probar": probar,
                "millwise": millwise
            ]
            
            NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/apertaster", parameters: dict) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            }
        }
        
        view.addSubview(playView)
        playView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(anotherView)
        anotherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.playView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeDataMessage()
        })
        
        self.anotherView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeDataMessage()
        })
        
        playView.applyBlock = { [weak self] in
            guard let self = self, let model = self.homeModel.value else { return }
            let productID = String(model.polysure?.nema?.first?.raptorium ?? 0)
            self.applyProduct(with: productID)
        }
        
        anotherView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = String(model.raptorium ?? 0)
            self.applyProduct(with: productID)
        }
        
        anotherView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let model = self.homeModel.value else { return }
            let productID = String(model.polysure?.nema?.first?.raptorium ?? 0)
            self.applyProduct(with: productID)
        }).disposed(by: disposeBag)
        
        playView
            .clickLabel
            .rx
            .tapGesture()
            .when(.recognized).subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let webVc = WebViewController()
                webVc.pageUrl = base_web_url + "/greenbeanCh"
                self.navigationController?.pushViewController(webVc, animated: true)
            }).disposed(by: disposeBag)
        
        getAddressInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeDataMessage()
    }
    
    
}

extension HomeViewController {
    
    func showPermissionAlert(from vc: UIViewController, feature: String) {
        let alert = UIAlertController(title: "\(feature)权限未开启",
                                      message: "请前往 设置 > 隐私 > \(feature)，开启权限后重试。",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        vc.present(alert, animated: true)
    }
    
    private func applyProduct(with productID: String) {
        
        //判断权限
        let kakier = self.homeModel.value?.kakier ?? 0
        if kakier == 1 {
            let status = CLLocationManager().authorizationStatus
            if status == .authorizedAlways || status == .authorizedWhenInUse {
            }else {
                showPermissionAlert(from: self, feature: "")
                return
            }
        }
        
        //上报
        let locationInfo = LocationModelSingle.shared.locationInfo
        let probar = locationInfo?["probar"] ?? ""
        let cyston = locationInfo?["cyston"] ?? ""
        PongCombineManager.goYourPoint(with: productID, type: "1", publicfic: self.time, probar: probar, cyston: cyston)
        
        //设备
        let deeiidict = SoftConfig().backAllDict()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: deeiidict, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)!
            if let base64Data = jsonString.data(using: .utf8) {
                let base64String = base64Data.base64EncodedString()
                let dict = ["phrenlike": base64String, "apple": "1"]
                NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/amongel", parameters: dict) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        break
                    }
                }
            }
        } catch {
        
        }
        
        ViewHud.addLoadView()
        let dict = ["pinguly": productID, "home": "1"]
        NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/opportunityment", parameters: dict) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    let phrenlike = success.phrenlike
                    let talkability = phrenlike?.talkability ?? ""
                    if talkability.contains("ios://pera.lend.app/flamingoCypr") {
                        let productID = getQueryParameter(from: talkability, parameterName: "pinguly") ?? ""
                        let muidVc = AVMuidViewController()
                        muidVc.productID = productID
                        self.navigationController?.pushViewController(muidVc, animated: true)
                        //去认证--产品详情
                        //                        getProductDetailInfo(with: productID)
                    }else {
                        let webVc = WebViewController()
                        webVc.pageUrl = talkability
                        self.navigationController?.pushViewController(webVc, animated: true)
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
    
    private func getHomeDataMessage() {
        ViewHud.addLoadView()
        NetworkManager.shared.getRequest(url: "/plapiall/phrenlike") { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self, let homeModel = success.phrenlike else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    self.homeModel.accept(homeModel)
                    let potamowise = homeModel.polysure?.potamowise ?? ""
                    if potamowise == "partpowerfy" {//a
                        self.playView.homeModel = homeModel
                        self.playView.isHidden = false
                        self.anotherView.isHidden = true
                    }else if potamowise == "finalation" {//b
                        self.anotherView.homeModel = homeModel
                        self.playView.isHidden = true
                        self.anotherView.isHidden = false
                        self.anotherView.tableView.reloadData()
                    }
                }
                ViewHud.hideLoadView()
                self.playView.scrollView.mj_header?.endRefreshing()
                self.anotherView.tableView.mj_header?.endRefreshing()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                self?.playView.scrollView.mj_header?.endRefreshing()
                self?.anotherView.tableView.mj_header?.endRefreshing()
                break
            }
        }
    }
    
    func getQueryParameter(from urlString: String, parameterName: String) -> String? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.first(where: { $0.name == parameterName })?.value
    }
    
    
}

extension HomeViewController {
    
    //产品线抗清 ====跳转
    private func getProductDetailInfo(with productID: String) {
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
                            let muidVc = AVMuidViewController()
                            muidVc.productID = productID
                            self.navigationController?.pushViewController(muidVc, animated: true)
                        }else {
                            let songfic = success.phrenlike?.formee?.songfic ?? ""
                            orderNoInfo(with: songfic) { pageUrl in
                                let webVc = WebViewController()
                                webVc.pageUrl = pageUrl
                                self.navigationController?.pushViewController(webVc, animated: true)
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

extension HomeViewController {
    
    private func getAddressInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .getRequest(url: "/plapiall/crass") { result in
                switch result {
                case .success(let success):
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        let rurArray = AddressModel.getAddressModelArray(dataSourceArr: success.phrenlike?.rur ?? [])
                        AdressModelSingle.shared.modelArray = rurArray
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


extension HomeViewController {
     
    private func uploadinfo() {
        
    }
    
}
