//
//  OrderViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit

class OrderViewController: BaseViewController {
    
    var orderType: String = ""
    
    lazy var orderView: OrderView = {
        let orderView = OrderView()
        return orderView
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
        }
        
        orderView.twoblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "7")
        }
        
        orderView.threeblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "6")
        }
        
        orderView.fourblock = { [weak self] in
            guard let self = self else { return }
            changeBtnColor(with: "5")
        }
        
    }
    

}


extension OrderViewController {
    
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
    
}
