//
//  HomeViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxRelay
import MJRefresh

class HomeViewController: BaseViewController {
    
    lazy var playView: HomeView = {
        let playView = HomeView()
        return playView
    }()
    
    var homeModel = BehaviorRelay<phrenlikeModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(playView)
        playView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.playView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeDataMessage()
        })
        
        playView.applyBlock = { [weak self] in
            guard let self = self, let model = self.homeModel.value else { return }
            let productID = String(model.polysure?.nema?.first?.raptorium ?? 0)
            self.applyProduct(with: productID)
        }
        
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
    
    private func applyProduct(with productID: String) {
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
                        //去认证--产品详情
                        getProductDetailInfo(with: productID)
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
                    }else {//b
                        
                    }
                }
                ViewHud.hideLoadView()
                self.playView.scrollView.mj_header?.endRefreshing()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                self?.playView.scrollView.mj_header?.endRefreshing()
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
