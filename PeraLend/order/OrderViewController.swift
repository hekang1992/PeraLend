//
//  OrderViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/24.
//

import UIKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    var orderType: String = ""
    
    lazy var orderView: OrderView = {
        let orderView = OrderView()
        return orderView
    }()
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        return emptyView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headView)
        headView.nameLabel.text = "Order List"
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: screenwidth, height: 30))
            make.centerX.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            popToSelectController()
        }
        
        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
        }
        
        changeBtnColor(with: orderType)
        
        orderView.oneblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "4")
            getOrderListInfo(with: "4")
            orderType = "4"
        }
        
        orderView.twoblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "7")
            getOrderListInfo(with: "7")
            orderType = "7"
        }
        
        orderView.threeblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "6")
            getOrderListInfo(with: "6")
            orderType = "6"
        }
        
        orderView.fourblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "5")
            getOrderListInfo(with: "5")
            orderType = "5"
        }
        
        self.orderView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getOrderListInfo(with: orderType)
        })
        
        self.orderView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = model.sesquireallyment?.therier ?? 0
            applyProduct(with: String(productID))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOrderListInfo(with: orderType)
    }
    

}


extension OrderViewController {
    
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
    
    func getQueryParameter(from urlString: String, parameterName: String) -> String? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.first(where: { $0.name == parameterName })?.value
    }
    
    private func changeBtnColor(with orderType: String) {
        if orderType == "4" {
            orderView.oneBtn.isSelected = true
            orderView.twoBtn.isSelected = false
            orderView.threeBtn.isSelected = false
            orderView.fourBtn.isSelected = false
        }else if orderType == "7" {
            orderView.oneBtn.isSelected = false
            orderView.twoBtn.isSelected = true
            orderView.threeBtn.isSelected = false
            orderView.fourBtn.isSelected = false
        }else if orderType == "6" {
            orderView.oneBtn.isSelected = false
            orderView.twoBtn.isSelected = false
            orderView.threeBtn.isSelected = true
            orderView.fourBtn.isSelected = false
        }else if orderType == "5" {
            orderView.oneBtn.isSelected = false
            orderView.twoBtn.isSelected = false
            orderView.threeBtn.isSelected = false
            orderView.fourBtn.isSelected = true
        }
    }
    
    private func getOrderListInfo(with orderType: String) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/potamowise", parameters: ["bringster": orderType]) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    let rurModelArray = success.phrenlike?.rur ?? []
                    self.orderView.rurModelArray = rurModelArray
                    self.orderView.tableView.reloadData()
                    self.emptyView.removeFromSuperview()
                    if rurModelArray.isEmpty {
                        self.orderView.tableView.insertSubview(emptyView, at: 0)
                        self.emptyView.snp.makeConstraints { make in
                            make.top.equalToSuperview().offset(200)
                            make.centerX.equalToSuperview()
                            make.left.equalTo((screenwidth - 200) * 0.5)
                            make.size.equalTo(CGSize(width: 200, height: 200))
                        }
                    }
                }
                ViewHud.hideLoadView()
                self.orderView.tableView.reloadData()
                self.orderView.tableView.mj_header?.endRefreshing()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                self?.orderView.tableView.mj_header?.endRefreshing()
                break
            }
        }
    }
    
    
    
}
