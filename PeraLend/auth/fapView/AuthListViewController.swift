//
//  AuthListViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/22.
//

import UIKit

class AuthListViewController: BaseViewController {
    
    var productID: String = ""
    
    var lystArray: [[String]] = []
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "list_fad_fda")
        return headImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 9
        return whiteView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "mai_aiu_d")
        return iconImageView
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    lazy var icon1ImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "od_d_da")
        return iconImageView
    }()
    private let scrollView1 = UIScrollView()
    private let contentView1 = UIView()
    
    let locationService = LocationService()  // 保留引用
    var time: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.nameLabel.text = "Select The Id Type"
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: screenwidth, height: 30))
            make.centerX.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 338, height: 133))
            make.top.equalTo(headView.snp.bottom).offset(20)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(338)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 151, height: 32))
            make.left.equalTo(whiteView.snp.left).offset(-5)
        }
        
        whiteView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        view.addSubview(icon1ImageView)
        icon1ImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 151, height: 32))
            make.left.equalTo(whiteView.snp.left).offset(-5)
        }
        
        whiteView.addSubview(scrollView1)
        scrollView1.addSubview(contentView1)
        
        scrollView1.snp.makeConstraints { make in
            make.top.equalTo(icon1ImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        contentView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView1)
        }
        
        loadOneTitles()
        loadTwoTitles()
        
        time = String(Int(Date().timeIntervalSince1970 * 1000))
        locationService.startLocation { locationInfo in
            LocationModelSingle.shared.locationInfo = locationInfo
        }
        
        
    }
    
    
}

extension AuthListViewController {
    
    private func loadOneTitles() {
        guard let titles = lystArray.first else { return }
        
        var previousView: UIView?
        
        for (index, title) in titles.enumerated() {
            let listView = PhotoFaceListView()
            listView.nameLabel.text = title
            contentView.addSubview(listView)
            
            listView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(50)
                
                if let previousView = previousView {
                    make.top.equalTo(previousView.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }
            }
            
            listView.clickblock = { [weak self] title in
                guard let self = self else { return }
                goDocument(with: title, productID: productID)
            }
            
            previousView = listView
        }
        
        // 最后一个元素距离底部 5 像素
        if let lastView = previousView {
            contentView.snp.makeConstraints { make in
                make.bottom.equalTo(lastView.snp.bottom).offset(5)
            }
        }
    }
    
    private func loadTwoTitles() {
        guard let titles = lystArray.last else { return }
        
        var previousView: UIView?
        
        for (index, title) in titles.enumerated() {
            let listView = PhotoFaceListView()
            listView.nameLabel.text = title
            contentView1.addSubview(listView)
            
            listView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(50)
                
                if let previousView = previousView {
                    make.top.equalTo(previousView.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }
            }
            
            listView.clickblock = { [weak self] title in
                guard let self = self else { return }
                goDocument(with: title, productID: productID)
            }
            
            previousView = listView
        }
        
        // 最后一个元素距离底部 5 像素
        if let lastView = previousView {
            contentView1.snp.makeConstraints { make in
                make.bottom.equalTo(lastView.snp.bottom).offset(5)
            }
        }
    }
}

extension AuthListViewController {
    
    
    private func goDocument(with type: String, productID: String) {
        let faceVc = PhotoFaceViewController()
        faceVc.productID = productID
        faceVc.type = type
        self.navigationController?.pushViewController(faceVc, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let locationInfo = LocationModelSingle.shared.locationInfo
            let probar = locationInfo?["probar"] ?? ""
            let cyston = locationInfo?["cyston"] ?? ""
            PongCombineManager.goYourPoint(with: self.productID, type: "2", publicfic: self.time, probar: probar, cyston: cyston)
        }
        
        
    }
}
